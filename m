Return-Path: <linux-tip-commits+bounces-4950-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FACA87385
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0123B69F5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 19:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421AD1DB548;
	Sun, 13 Apr 2025 19:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nqr/UgRl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UB9HhCaV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660A17A58F;
	Sun, 13 Apr 2025 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744572417; cv=none; b=Xe44YRbFbfegRTptMMokYn1N2LNYd7GUUGsptaMhbRmRfoXXc2mz4e3quXfaDVRfB33ZtOYn8TuaPuwJi5ZA46b5pCTKbTH9Sihai8FAUvWZkaT8RnxnMYluSZEmZfJ7N6xSbBBPd7OjMeUn2SYSVZKKmRWZerOGUA9kzTUpiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744572417; c=relaxed/simple;
	bh=Jiyd4ShW6SqiulXF1Noull9T0S6CvDvb34nRkv3K7mg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V4iP5vVkJ9V4gL2Mp7nOcaxc7cB+VRWNZ8DRgcOI+ve+oQ6U3VM8LRm9UpDrGKnEnWEQckfLD+EOEY11amEsP0Sfew/Ju6MnJsjg9iwUMWRlRj92Q5BAb1wa9nKkyog5mmsAQOojjYh5d+HjrWITKlt6OthobvPl8qI4B815v+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nqr/UgRl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UB9HhCaV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 19:26:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744572413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRj5D5zcVv4GOpBa53Cg5MizdWuEX81U0FzbddHfElU=;
	b=Nqr/UgRlXWpD2J6BZZCjKVB4k8eMAwIlk+ktTjCLLf7ZfO1knlxf6z9EiKXwRTFUEt5TLS
	MqJP4aEWvKMyW1YSfV1QT5roRTNBPJX2pD53lmmP34FOejka+5UUu/rbA6qx1oKSkiHNsm
	XFwN9MvGe7o2Sp3zepBTqOPezGxLJ55NaPauMjASIWLdJRFD3E0FaMr+q2zteSErD3ZH+y
	hyn61tF8LQNf84o4NQHYLeUvgWgPaKgQU/P01kiMVVP4MoqTgEWOjMpEPXpYN1nPdNmXr/
	hDs8Im4b4rtgD3OMvm6h2W6OgmT/JfMd3PC8DBTjbYOE/lP5/SVxJjIOLV2UgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744572413;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRj5D5zcVv4GOpBa53Cg5MizdWuEX81U0FzbddHfElU=;
	b=UB9HhCaVYgknFDUi0oqwdDF7cRujL+UBmDea3DH7ml0pYK0IeHQVn+NvJbJAucQ6CCSj6M
	0jAP179fMwieVFDg==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/uaccess: Use asm_inline() instead of asm() in
 __untagged_addr()
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250407072129.33440-1-ubizjak@gmail.com>
References: <20250407072129.33440-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457240687.31282.7688867461399769674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4850074ff06fce894a9946c5d3ab8ea13fa33e43
Gitweb:        https://git.kernel.org/tip/4850074ff06fce894a9946c5d3ab8ea13fa33e43
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Mon, 07 Apr 2025 09:21:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 13 Apr 2025 21:12:04 +02:00

x86/uaccess: Use asm_inline() instead of asm() in __untagged_addr()

Use asm_inline() to instruct the compiler that the size of asm()
is the minimum size of one instruction, ignoring how many instructions
the compiler thinks it is. ALTERNATIVE macro that expands to several
pseudo directives causes instruction length estimate to count
more than 20 instructions.

bloat-o-meter reports minimal code size increase
(x86_64 defconfig with CONFIG_ADDRESS_MASKING, gcc-14.2.1):

  add/remove: 2/2 grow/shrink: 5/1 up/down: 2365/-1995 (370)

	Function                          old     new   delta
	-----------------------------------------------------
	do_get_mempolicy                    -    1449   +1449
	copy_nodes_to_user                  -     226    +226
	__x64_sys_get_mempolicy            35     213    +178
	syscall_user_dispatch_set_config  157     332    +175
	__ia32_sys_get_mempolicy           31     206    +175
	set_syscall_user_dispatch          29     181    +152
	__do_sys_mremap                  2073    2083     +10
	sp_insert                         133     117     -16
	task_set_syscall_user_dispatch    172       -    -172
	kernel_get_mempolicy             1807       -   -1807

  Total: Before=21423151, After=21423521, chg +0.00%

The code size increase is due to the compiler inlining
more functions that inline untagged_addr(), e.g:

task_set_syscall_user_dispatch() is now fully inlined in
set_syscall_user_dispatch():

	000000000010b7e0 <set_syscall_user_dispatch>:
	  10b7e0:	f3 0f 1e fa          	endbr64
	  10b7e4:	49 89 c8             	mov    %rcx,%r8
	  10b7e7:	48 89 d1             	mov    %rdx,%rcx
	  10b7ea:	48 89 f2             	mov    %rsi,%rdx
	  10b7ed:	48 89 fe             	mov    %rdi,%rsi
	  10b7f0:	65 48 8b 3d 00 00 00 	mov    %gs:0x0(%rip),%rdi
	  10b7f7:	00
	  10b7f8:	e9 03 fe ff ff       	jmp    10b600 <task_set_syscall_user_dispatch>

that after inlining becomes:

	000000000010b730 <set_syscall_user_dispatch>:
	  10b730:	f3 0f 1e fa          	endbr64
	  10b734:	65 48 8b 05 00 00 00 	mov    %gs:0x0(%rip),%rax
	  10b73b:	00
	  10b73c:	48 85 ff             	test   %rdi,%rdi
	  10b73f:	74 54                	je     10b795 <set_syscall_user_dispatch+0x65>
	  10b741:	48 83 ff 01          	cmp    $0x1,%rdi
	  10b745:	74 06                	je     10b74d <set_syscall_user_dispatch+0x1d>
	  10b747:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
	  10b74c:	c3                   	ret
	  10b74d:	48 85 f6             	test   %rsi,%rsi
	  10b750:	75 7b                	jne    10b7cd <set_syscall_user_dispatch+0x9d>
	  10b752:	48 85 c9             	test   %rcx,%rcx
	  10b755:	74 1a                	je     10b771 <set_syscall_user_dispatch+0x41>
	  10b757:	48 89 cf             	mov    %rcx,%rdi
	  10b75a:	49 b8 ef cd ab 89 67 	movabs $0x123456789abcdef,%r8
	  10b761:	45 23 01
	  10b764:	90                   	nop
	  10b765:	90                   	nop
	  10b766:	90                   	nop
	  10b767:	90                   	nop
	  10b768:	90                   	nop
	  10b769:	90                   	nop
	  10b76a:	90                   	nop
	  10b76b:	90                   	nop
	  10b76c:	49 39 f8             	cmp    %rdi,%r8
	  10b76f:	72 6e                	jb     10b7df <set_syscall_user_dispatch+0xaf>
	  10b771:	48 89 88 48 08 00 00 	mov    %rcx,0x848(%rax)
	  10b778:	48 89 b0 50 08 00 00 	mov    %rsi,0x850(%rax)
	  10b77f:	48 89 90 58 08 00 00 	mov    %rdx,0x858(%rax)
	  10b786:	c6 80 60 08 00 00 00 	movb   $0x0,0x860(%rax)
	  10b78d:	f0 80 48 08 20       	lock orb $0x20,0x8(%rax)
	  10b792:	31 c0                	xor    %eax,%eax
	  10b794:	c3                   	ret
	  10b795:	48 09 d1             	or     %rdx,%rcx
	  10b798:	48 09 f1             	or     %rsi,%rcx
	  10b79b:	75 aa                	jne    10b747 <set_syscall_user_dispatch+0x17>
	  10b79d:	48 c7 80 48 08 00 00 	movq   $0x0,0x848(%rax)
	  10b7a4:	00 00 00 00
	  10b7a8:	48 c7 80 50 08 00 00 	movq   $0x0,0x850(%rax)
	  10b7af:	00 00 00 00
	  10b7b3:	48 c7 80 58 08 00 00 	movq   $0x0,0x858(%rax)
	  10b7ba:	00 00 00 00
	  10b7be:	c6 80 60 08 00 00 00 	movb   $0x0,0x860(%rax)
	  10b7c5:	f0 80 60 08 df       	lock andb $0xdf,0x8(%rax)
	  10b7ca:	31 c0                	xor    %eax,%eax
	  10b7cc:	c3                   	ret
	  10b7cd:	48 8d 3c 16          	lea    (%rsi,%rdx,1),%rdi
	  10b7d1:	48 39 fe             	cmp    %rdi,%rsi
	  10b7d4:	0f 82 78 ff ff ff    	jb     10b752 <set_syscall_user_dispatch+0x22>
	  10b7da:	e9 68 ff ff ff       	jmp    10b747 <set_syscall_user_dispatch+0x17>
	  10b7df:	b8 f2 ff ff ff       	mov    $0xfffffff2,%eax
	  10b7e4:	c3                   	ret

Please note a series of NOPs that get replaced with an alternative:

	    11f0:	65 48 23 05 00 00 00 	and    %gs:0x0(%rip),%rax
	    11f7:	00

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250407072129.33440-1-ubizjak@gmail.com
---
 arch/x86/include/asm/uaccess_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index 4c13883..c8a5ae3 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -26,8 +26,8 @@ extern unsigned long USER_PTR_MAX;
  */
 static inline unsigned long __untagged_addr(unsigned long addr)
 {
-	asm (ALTERNATIVE("",
-			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
+	asm_inline (ALTERNATIVE("", "and " __percpu_arg([mask]) ", %[addr]",
+				X86_FEATURE_LAM)
 	     : [addr] "+r" (addr)
 	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
 

