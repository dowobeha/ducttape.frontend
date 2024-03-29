package ducttape.syntax

import java.io.File

import scala.util.parsing.combinator.Parsers
import scala.util.parsing.combinator.RegexParsers
import scala.util.parsing.input.CharArrayReader
import scala.util.parsing.input.Position
import scala.util.parsing.input.Positional

import ducttape.syntax.AbstractSyntaxTree._
import ducttape.util.IO

object GrammarParser extends RegexParsers {

  override val skipWhitespace = false;

  def readTape(file: File): WorkflowDefinition = {
    //val grammar = new Grammar(file)
    val result: ParseResult[Seq[Block]] = parseAll(Grammar.blocks, IO.read(file, "UTF-8"))    
    val pos = result.next.pos
    
    return result match {
      case Success(blocks:Seq[Block], _) => new WorkflowDefinition(file,blocks)
      case Failure(msg, _) =>
        throw new FileFormatException("ERROR: line %d column %d: %s".format(pos.line, pos.column, msg), file, pos)
      case Error(msg, _) =>
        throw new FileFormatException("HARD ERROR: line %d column %d: %s".format(pos.line, pos.column, msg), file, pos)
    }    
  }
  
}
