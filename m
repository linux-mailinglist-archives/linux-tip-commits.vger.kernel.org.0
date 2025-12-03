Return-Path: <linux-tip-commits+bounces-7581-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52F0CA04D4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 18:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52EE63114F8B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D39362130;
	Wed,  3 Dec 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2DZzwLl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954563624C9;
	Wed,  3 Dec 2025 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764781025; cv=none; b=MUTVxGww+qfTTpzAYZ67KmsMLWF+7pNq9FO2rNZT8ff7iuMsshLrHotMPSlVCCBpmb75Pl2ANKvM9ZSHPL4BvK1FzZAEEkrXzlIy8sXNqAiBFZ+wv1IUf7i2npPSZ6w6Xa8R3V8WdZzIjBORwgJxGvDQjZvzu5D0r6xEyN7qWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764781025; c=relaxed/simple;
	bh=fd76oAhVcXr0MJlA0siC9kEEWHOGwHe2syCbUnb+fGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu/qJdzS84ummGoSqlbAxJSvUSa0UPDMBg3TV0JQqf5bJ7dDkDugVhAu6ozYkSIUbXOZNBektGH8ab1RpEzSr/0/hH5ho57ffsbftVoDIcGjmr+K+OUBIynHfoLrcCyyfp5BMAUmNV28/e49Au8CoZyVNLpP7Cci6W70w9k9b/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2DZzwLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F029C116B1;
	Wed,  3 Dec 2025 16:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764781025;
	bh=fd76oAhVcXr0MJlA0siC9kEEWHOGwHe2syCbUnb+fGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2DZzwLl3VLWhrOOsiLGW2J2ys7leEhf7mOWUd+eEhxLhqI2bTvS9eCpq9Hc2K/8I
	 7G4O7YDpLY1cC+9usPOUh0ydo8JqkodNBhRFfU/Mqm5kYab5eTgUP0pIxF0WECFaPO
	 /dzANBdmRlU11JdJtOCjHLsOwpg3ZwpgCI3eBoHjlIxKbPPowerd033UXApI4ssS02
	 JWsklAkTqucKPT8nSJxzY9P1asP0V84VTeRNbifQS/v46hiWe7yvYHovHrcFGv2yKc
	 FoxJJzAr3T/FTGZ+mY5uawkZg78Ljv/mkbfqGrt30qAxEVgRb5Wz2FndH15fbFnVsP
	 zEyk4WOWL75Sw==
Date: Wed, 3 Dec 2025 17:57:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool: Consolidate annotation macros
Message-ID: <aTBr3ImmrJQe4G49@gmail.com>
References: <c05ff40d3383e85c3b59018ef0b3c7aaf993a60d.1764694625.git.jpoimboe@kernel.org>
 <176478003405.498.13298696533128884255.tip-bot2@tip-bot2>
 <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgzL-bCggZOuDU7_f-1jpjus8Oaqtek9T8GdGUexnHYkg@mail.gmail.com>

* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 3 Dec 2025 at 08:40, tip-bot2 for Josh Poimboeuf
> <tip-bot2@linutronix.de> wrote:
> >
> > Consolidate __ASM_ANNOTATE into a single macro which is used by both C
> > and asm.  This also makes the code generation a bit more palatable by
> > putting it all on a single line.
> 
> No objections, but I just wanted to say that when stating "this makes
> the code generation more palatable", it would be good to actually show
> *how* it does it (with just an example).
> 
> Because it's hard to read that diff and figure out what the actual
> effect is. I can just about see it, but...

Sorry, should have added this to the changelog.

Find below a diff of the arch/x86/kernel/process.s output
of your tree versus current tip:objtool/urgent.

Thanks,

	Ingo

--- process.s.linus	2025-12-03 17:52:48.210562871 +0100
+++ process.s.fixed	2025-12-03 17:53:11.003622421 +0100
@@ -13,12 +13,8 @@
 .align 4						
 .globl __SCT__x86_idle		
 __SCT__x86_idle:			
-911:
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 911b - .
-	.long 1
-	.popsection
-	jmp __x86_return_thunk						
+911: .pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 911b - .; .long 1; .popsection					
+jmp __x86_return_thunk						
 .byte 0x0f, 0xb9, 0xcc				
 .type __SCT__x86_idle, @function	
 .size __SCT__x86_idle, . - __SCT__x86_idle 


@@ -58,35 +54,22 @@ default_idle:
 # 107 "/home/mingo/tip/arch/x86/include/asm/paravirt.h" 1
 	# ALT: oldinstr
 771:
-	911:
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 911b - .
-	.long 2
-	.popsection
+	911: .pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 911b - .; .long 2; .popsection
 	call *pv_ops+8(%rip);	# pv_ops.irq.safe_halt
 772:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte (((1 << 1) << 16) | (( 3*32+21)))
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	call BUG_func
 775:

...
@@ -139,12 +122,8 @@ mwait_idle:
 	1:jmp .L5	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L5 - . 	#
 	 .quad  cpu_buf_idle_clear + 1 - . 	#,
 	.popsection 
@@ -183,25 +162,16 @@ mwait_idle:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte (22*32 + (7))
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	clflush (%rax)	# pretmp_19
 775:
@@ -589,14 +559,9 @@ set_cpuid_faulting:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -607,12 +572,8 @@ set_cpuid_faulting:
 	1: jmp .L32 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L32 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -807,12 +768,8 @@ arch_release_task_struct:
 	1: jmp .L60 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L60 - . 	#
 	 .quad  __fpu_state_size_dynamic + 0 + 2 - . 	#,
 	.popsection 
@@ -1027,25 +984,16 @@ copy_thread:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L78	#
 775:
@@ -1055,37 +1003,24 @@ copy_thread:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 516	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $16, boot_cpu_data+112(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $16, boot_cpu_data+112(%rip)	#,
  jnz .L77	#
  jmp .L78	#
 .popsection
@@ -1283,25 +1218,16 @@ flush_thread:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L103	#
 775:
@@ -1311,37 +1237,24 @@ flush_thread:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 516	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $16, boot_cpu_data+112(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $16, boot_cpu_data+112(%rip)	#,
  jnz .L104	#
  jmp .L103	#
 .popsection
@@ -1820,20 +1733,12 @@ native_tss_update_io_bitmap:
 #APP
 # 486 "/home/mingo/tip/arch/x86/kernel/process.c" 1
 	855: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 855b - .
-	.long 3
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 855b - .; .long 3; .popsection
 # 0 "" 2
 # 486 "/home/mingo/tip/arch/x86/kernel/process.c" 1
 	1:	 .byte 0x0f, 0x0b ; 
 .pushsection __bug_table,"aw"
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
 	2:
 		.long 1b - .	# bug_entry::bug_addr
 	.long .LC4 - .	# bug_entry::format	#
@@ -1842,19 +1747,11 @@ native_tss_update_io_bitmap:
 	.word 2307	# bug_entry::flags	#
 	.org 2b + 16	#
 .popsection
-.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 1b - .
-	.long 8
-	.popsection
-	
+.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 1b - .; .long 8; .popsection
 # 0 "" 2
 # 486 "/home/mingo/tip/arch/x86/kernel/process.c" 1
 	856: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 856b - .
-	.long 4
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 856b - .; .long 4; .popsection
 # 0 "" 2
 # /home/mingo/tip/arch/x86/include/asm/bitops.h:75: 		asm_inline volatile(LOCK_PREFIX "andb %b1,%0"
 # 75 "/home/mingo/tip/arch/x86/include/asm/bitops.h" 1
@@ -1886,11 +1783,7 @@ native_tss_update_io_bitmap:
 #APP
 # 328 "/home/mingo/tip/arch/x86/include/asm/desc.h" 1
 	463: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 463b - .
-	.long 3
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 463b - .; .long 3; .popsection
 # 0 "" 2
 #NO_APP
 	call	debug_locks_off	#
@@ -1906,11 +1799,7 @@ native_tss_update_io_bitmap:
 #APP
 # 328 "/home/mingo/tip/arch/x86/include/asm/desc.h" 1
 	465: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 465b - .
-	.long 4
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 465b - .; .long 4; .popsection
 # 0 "" 2
 #NO_APP
 	jmp	.L149	#
@@ -1936,11 +1825,7 @@ native_tss_update_io_bitmap:
 	lea (2f)(%rip), %rdi	# bug
 1:
 .pushsection __bug_table,"aw"
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
 	2:
 		.long 1b - .	# bug_entry::bug_addr
 	.long .LC6 - .	# bug_entry::format	#
@@ -2003,11 +1888,7 @@ ret_from_fork:
 #APP
 # 193 "/home/mingo/tip/include/linux/entry-common.h" 1
 	768: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 768b - .
-	.long 3
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 768b - .; .long 3; .popsection
 # 0 "" 2
 # /home/mingo/tip/arch/x86/include/asm/current.h:23: 		return this_cpu_read_const(const_current_task);
 #NO_APP
@@ -2020,12 +1901,8 @@ ret_from_fork:
 	1: jmp .L174 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L174 - . 	#
 	 .quad  rseq_debug_enabled + 0 + 2 - . 	#,
 	.popsection 
@@ -2062,12 +1939,8 @@ ret_from_fork:
 	1: jmp .L182 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L182 - . 	#
 	 .quad  randomize_kstack_offset + 0 + 2 - . 	#,
 	.popsection 
@@ -2087,25 +1960,16 @@ ret_from_fork:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L185	#
 775:
@@ -2115,37 +1979,24 @@ ret_from_fork:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 686	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $64, boot_cpu_data+133(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $64, boot_cpu_data+133(%rip)	#,
  jnz .L184	#
  jmp .L185	#
 .popsection
@@ -2163,20 +2014,12 @@ ret_from_fork:
 #APP
 # 195 "/home/mingo/tip/include/linux/entry-common.h" 1
 	769: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 769b - .
-	.long 4
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 769b - .; .long 4; .popsection
 # 0 "" 2
 # /home/mingo/tip/include/linux/irq-entry-common.h:295: 	instrumentation_begin();
 # 295 "/home/mingo/tip/include/linux/irq-entry-common.h" 1
 	759: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 759b - .
-	.long 3
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 759b - .; .long 3; .popsection
 # 0 "" 2
 # /home/mingo/tip/arch/x86/include/asm/atomic64_64.h:15: 	return __READ_ONCE((v)->counter);
 #NO_APP
@@ -2189,11 +2032,7 @@ ret_from_fork:
 #APP
 # 299 "/home/mingo/tip/include/linux/irq-entry-common.h" 1
 	760: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 760b - .
-	.long 4
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 760b - .; .long 4; .popsection
 # 0 "" 2
 # /home/mingo/tip/arch/x86/include/asm/processor.h:709: 	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
 #NO_APP
@@ -2209,25 +2048,16 @@ ret_from_fork:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte (22*32 + (1*32+ 1))
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	div %ecx	# tmp152
 	
@@ -2280,25 +2110,16 @@ ret_from_fork:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 7*32+26)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	call write_ibpb
 775:
@@ -2534,25 +2355,16 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L234	#
 775:
@@ -2562,37 +2374,24 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 441	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $2, boot_cpu_data+103(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $2, boot_cpu_data+103(%rip)	#,
  jnz .L235	#
  jmp .L234	#
 .popsection
@@ -2613,14 +2412,9 @@ speculation_ctrl_update:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -2631,12 +2425,8 @@ speculation_ctrl_update:
 	1: jmp .L239 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L239 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -2653,12 +2443,8 @@ speculation_ctrl_update:
 	1: jmp .L257 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L257 - . 	#
 	 .quad  switch_to_cond_stibp + 0 + 2 - . 	#,
 	.popsection 
@@ -2708,25 +2494,16 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L237	#
 775:
@@ -2736,37 +2513,24 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 248	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $1, boot_cpu_data+79(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $1, boot_cpu_data+79(%rip)	#,
  jnz .L238	#
  jmp .L237	#
 .popsection
@@ -2792,25 +2556,16 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L245	#
 775:
@@ -2820,37 +2575,24 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 252	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $16, boot_cpu_data+79(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $16, boot_cpu_data+79(%rip)	#,
  jnz .L244	#
  jmp .L245	#
 .popsection
@@ -2919,25 +2661,16 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L242	#
 775:
@@ -2947,37 +2680,24 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 607	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $128, boot_cpu_data+123(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $128, boot_cpu_data+123(%rip)	#,
  jnz .L243	#
  jmp .L242	#
 .popsection
@@ -3022,14 +2742,9 @@ speculation_ctrl_update:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -3040,12 +2755,8 @@ speculation_ctrl_update:
 	1: jmp .L250 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L250 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -3066,25 +2777,16 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L240	#
 775:
@@ -3094,37 +2796,24 @@ speculation_ctrl_update:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 440	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $1, boot_cpu_data+103(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $1, boot_cpu_data+103(%rip)	#,
  jnz .L243	#
  jmp .L240	#
 .popsection
@@ -3197,14 +2886,9 @@ speculation_ctrl_update:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -3215,12 +2899,8 @@ speculation_ctrl_update:
 	1: jmp .L254 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L254 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -3243,14 +2923,9 @@ speculation_ctrl_update:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -3261,12 +2936,8 @@ speculation_ctrl_update:
 	1: jmp .L252 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L252 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -3551,14 +3222,9 @@ __switch_to_xtra:
 # 70 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: rdmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 9 
  .popsection
@@ -3574,12 +3240,8 @@ __switch_to_xtra:
 	1: jmp .L310 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L310 - . 	#
 	 .quad  __tracepoint_read_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -3606,14 +3268,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -3624,12 +3281,8 @@ __switch_to_xtra:
 	1: jmp .L312 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L312 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -3665,25 +3318,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L318	#
 775:
@@ -3693,37 +3337,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 441	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $2, boot_cpu_data+103(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $2, boot_cpu_data+103(%rip)	#,
  jnz .L317	#
  jmp .L318	#
 .popsection
@@ -3744,12 +3375,8 @@ __switch_to_xtra:
 	1: jmp .L342 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L342 - . 	#
 	 .quad  switch_to_cond_stibp + 0 + 2 - . 	#,
 	.popsection 
@@ -3785,25 +3412,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L324	#
 775:
@@ -3813,37 +3431,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 248	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $1, boot_cpu_data+79(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $1, boot_cpu_data+79(%rip)	#,
  jnz .L325	#
  jmp .L324	#
 .popsection
@@ -3872,25 +3477,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L331	#
 775:
@@ -3900,37 +3496,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 252	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $16, boot_cpu_data+79(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $16, boot_cpu_data+79(%rip)	#,
  jnz .L330	#
  jmp .L331	#
 .popsection
@@ -4028,25 +3611,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L347	#
 775:
@@ -4056,37 +3630,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 441	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $2, boot_cpu_data+103(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $2, boot_cpu_data+103(%rip)	#,
  jnz .L348	#
  jmp .L347	#
 .popsection
@@ -4107,14 +3668,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -4125,12 +3681,8 @@ __switch_to_xtra:
 	1: jmp .L352 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L352 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -4147,12 +3699,8 @@ __switch_to_xtra:
 	1: jmp .L370 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L370 - . 	#
 	 .quad  switch_to_cond_stibp + 0 + 2 - . 	#,
 	.popsection 
@@ -4213,25 +3761,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L328	#
 775:
@@ -4241,37 +3780,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 607	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $128, boot_cpu_data+123(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $128, boot_cpu_data+123(%rip)	#,
  jnz .L329	#
  jmp .L328	#
 .popsection
@@ -4308,14 +3834,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -4326,12 +3847,8 @@ __switch_to_xtra:
 	1: jmp .L326 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L326 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -4352,25 +3869,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L321	#
 775:
@@ -4380,37 +3888,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 440	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $1, boot_cpu_data+103(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $1, boot_cpu_data+103(%rip)	#,
  jnz .L329	#
  jmp .L321	#
 .popsection
@@ -4445,14 +3940,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -4463,12 +3953,8 @@ __switch_to_xtra:
 	1: jmp .L336 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L336 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -4496,25 +3982,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L350	#
 775:
@@ -4524,37 +4001,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 248	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $1, boot_cpu_data+79(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $1, boot_cpu_data+79(%rip)	#,
  jnz .L351	#
  jmp .L350	#
 .popsection
@@ -4580,25 +4044,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L358	#
 775:
@@ -4608,37 +4063,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 252	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $16, boot_cpu_data+79(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $16, boot_cpu_data+79(%rip)	#,
  jnz .L357	#
  jmp .L358	#
 .popsection
@@ -4728,25 +4170,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L355	#
 775:
@@ -4756,37 +4189,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 607	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $128, boot_cpu_data+123(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $128, boot_cpu_data+123(%rip)	#,
  jnz .L356	#
  jmp .L355	#
 .popsection
@@ -4823,25 +4243,16 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte ( 3*32+21)
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	jmp .L353	#
 775:
@@ -4851,37 +4262,24 @@ __switch_to_xtra:
 # ALT: padding
 .skip -(((775f-774f)-(772b-771b)) > 0) * ((775f-774f)-(772b-771b)),0x90
 773:
-.pushsection .altinstructions,"a"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long 771b - .
+.pushsection .altinstructions, "aM", @progbits, 14
+ .long 771b - .
  .long 774f - .
  .4byte 440	#
  .byte 773b-771b
  .byte 775f-774f
 .popsection
 .pushsection .altinstr_replacement, "ax"
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	# ALT: replacement
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+# ALT: replacement
 774:
 	
 775:
 .popsection
 .pushsection .altinstr_aux,"ax"
 6:
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 testb $1, boot_cpu_data+103(%rip)	#,
+912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+ testb $1, boot_cpu_data+103(%rip)	#,
  jnz .L356	#
  jmp .L353	#
 .popsection
@@ -4909,14 +4307,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -4927,12 +4320,8 @@ __switch_to_xtra:
 	1: jmp .L363 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L363 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -4990,14 +4379,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -5008,12 +4392,8 @@ __switch_to_xtra:
 	1: jmp .L338 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L338 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -5039,14 +4419,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -5057,12 +4432,8 @@ __switch_to_xtra:
 	1: jmp .L340 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L340 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -5099,14 +4470,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -5117,12 +4483,8 @@ __switch_to_xtra:
 	1: jmp .L367 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L367 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -5151,14 +4513,9 @@ __switch_to_xtra:
 # 80 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: wrmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 8 
  .popsection
@@ -5169,12 +4526,8 @@ __switch_to_xtra:
 	1: jmp .L365 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L365 - . 	#
 	 .quad  __tracepoint_write_msr+8 + 0 + 2 - . 	#,
 	.popsection 
@@ -5269,20 +4622,12 @@ arch_cpu_idle_dead:
 #APP
 # 85 "/home/mingo/tip/arch/x86/include/asm/smp.h" 1
 	56: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 56b - .
-	.long 3
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 56b - .; .long 3; .popsection
 # 0 "" 2
 # 85 "/home/mingo/tip/arch/x86/include/asm/smp.h" 1
 	1:	 .byte 0x0f, 0x0b ; 
 .pushsection __bug_table,"aw"
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
 	2:
 		.long 1b - .	# bug_entry::bug_addr
 	.long .LC4 - .	# bug_entry::format	#
@@ -5378,12 +4723,8 @@ stop_this_cpu:
 	1:jmp .L422	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L422 - . 	#
 	 .quad  cpu_buf_idle_clear + 1 - . 	#,
 	.popsection 
@@ -5410,20 +4751,12 @@ stop_this_cpu:
 #APP
 # 854 "/home/mingo/tip/arch/x86/kernel/process.c" 1
 	862: nop
-	.pushsection .discard.annotate_insn,"M", @progbits, 8
-	.long 862b - .
-	.long 3
-	.popsection
-	
+	.pushsection ".discard.annotate_insn", "M", @progbits, 8; .long 862b - .; .long 3; .popsection
 # 0 "" 2
 # 854 "/home/mingo/tip/arch/x86/kernel/process.c" 1
 	1:	 .byte 0x0f, 0x0b ; 
 .pushsection __bug_table,"aw"
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
 	2:
 		.long 1b - .	# bug_entry::bug_addr
 	.long .LC4 - .	# bug_entry::format	#
@@ -5669,14 +5002,9 @@ arch_post_acpi_subsys_init:
 # 70 "/home/mingo/tip/arch/x86/include/asm/msr.h" 1
 	1: rdmsr
 2:
- .pushsection "__ex_table","a"
+ .pushsection __ex_table, "aM", @progbits, 12
  .balign 4
-912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	 .long (1b) - .
+ .long (1b) - .
  .long (2b) - .
  .long 9 
  .popsection
@@ -5693,12 +5021,8 @@ arch_post_acpi_subsys_init:
 	1: jmp .L457 # objtool NOPs this 	#
 	.pushsection __jump_table,  "aw" 
 	 .balign 8 
-	912:
-	.pushsection .discard.annotate_data,"M", @progbits, 8
-	.long 912b - .
-	.long 1
-	.popsection
-	.long 1b - . 
+	912: .pushsection ".discard.annotate_data", "M", @progbits, 8; .long 912b - .; .long 1; .popsection
+.long 1b - . 
 	.long .L457 - . 	#
 	 .quad  __tracepoint_read_msr+8 + 0 + 2 - . 	#,
 	.popsection 

