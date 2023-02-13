Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24106943EA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Feb 2023 12:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBMLKh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Feb 2023 06:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjBMLKe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Feb 2023 06:10:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C4D53E;
        Mon, 13 Feb 2023 03:10:31 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:10:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676286628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMQEMQp0la9EqmRrVem1Nibbwm9NyFzfyphebRnIlyc=;
        b=0eTluQKEenzskYfb+C8QzOtS0VHMNCUVMtnO0UxsSjH/4hhoJEsl20f/pKbcKHo0hlSJfk
        l0ULlGu5Fn43IcAqwHhOI+QNCAnCkOKEp2MPABACf6A6/PHKNUsBLbp280nUc0HgKvzJqV
        bVGmQs0PuodFZOci2X9mymRQDU1njI4MsaGoPBudbYON/O5bGfNJDvUMspoaB1jfEtfJOK
        dNoSQnBl+GZJhUm6rVcYyvtqxui5xBMKK58CNz5RxB8T54NpYrRHsFdmCYHAvSiQyu4u2S
        d5k0kd7Sj39uS9CBKkePlxDyBBrN3n3hoazO5BGt/lmF85RNWitUH4qF6V0Lrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676286628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KMQEMQp0la9EqmRrVem1Nibbwm9NyFzfyphebRnIlyc=;
        b=g5wYUZb12vRvaHULgrtuzdrWqa5huiBoY9cG+ZWSAUC2hK+boGY8ewajZDXlhib5hNH32a
        bMuS0b+6ZfFSWdAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86: Fix FILL_RETURN_BUFFER
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux@weissschuh.net,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230208172245.783099843@infradead.org>
References: <20230208172245.783099843@infradead.org>
MIME-Version: 1.0
Message-ID: <167628662816.4906.5931554689698286479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2db38eca62cb9e893e7c0bfe0f6c5d327d990680
Gitweb:        https://git.kernel.org/tip/2db38eca62cb9e893e7c0bfe0f6c5d327d9=
90680
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 08 Feb 2023 18:18:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Feb 2023 11:26:09 +01:00

x86: Fix FILL_RETURN_BUFFER

With overlapping alternative validation fixed, objtool promptly
complains:

vmlinux.o: warning: objtool: __switch_to_asm+0x2c: stack layout conflict in a=
lternatives: .altinstr_replacement+0x47

.rela.altinstructions:

000000000000009c  0000000200000002 R_X86_64_PC32          0000000000000000 .t=
ext + 16dc
00000000000000a0  0000000600000002 R_X86_64_PC32          0000000000000000 .a=
ltinstr_replacement + 3a
00000000000000a8  0000000200000002 R_X86_64_PC32          0000000000000000 .t=
ext + 16dc
00000000000000ac  0000000600000002 R_X86_64_PC32          0000000000000000 .a=
ltinstr_replacement + 66

.text:

00000000000016b0 <__switch_to_asm>:
    16b0:       f3 0f 1e fa             endbr64
    16b4:       55                      push   %rbp
    16b5:       53                      push   %rbx
    16b6:       41 54                   push   %r12
    16b8:       41 55                   push   %r13
    16ba:       41 56                   push   %r14
    16bc:       41 57                   push   %r15
    16be:       48 89 a7 18 0b 00 00    mov    %rsp,0xb18(%rdi)
    16c5:       48 8b a6 18 0b 00 00    mov    0xb18(%rsi),%rsp
    16cc:       48 8b 9e 28 05 00 00    mov    0x528(%rsi),%rbx
    16d3:       65 48 89 1c 25 00 00 00 00      mov    %rbx,%gs:0x0     16d8:=
 R_X86_64_32S      fixed_percpu_data+0x28
    16dc:       eb 2a                   jmp    1708 <__switch_to_asm+0x58>
    16de:       90                      nop
    16df:       90                      nop
    16e0:       90                      nop
    16e1:       90                      nop
    16e2:       90                      nop
    16e3:       90                      nop
    16e4:       90                      nop
    16e5:       90                      nop
    16e6:       90                      nop
    16e7:       90                      nop
    16e8:       90                      nop
    16e9:       90                      nop
    16ea:       90                      nop
    16eb:       90                      nop
    16ec:       90                      nop
    16ed:       90                      nop
    16ee:       90                      nop
    16ef:       90                      nop
    16f0:       90                      nop
    16f1:       90                      nop
    16f2:       90                      nop
    16f3:       90                      nop
    16f4:       90                      nop
    16f5:       90                      nop
    16f6:       90                      nop
    16f7:       90                      nop
    16f8:       90                      nop
    16f9:       90                      nop
    16fa:       90                      nop
    16fb:       90                      nop
    16fc:       90                      nop
    16fd:       90                      nop
    16fe:       90                      nop
    16ff:       90                      nop
    1700:       90                      nop
    1701:       90                      nop
    1702:       90                      nop
    1703:       90                      nop
    1704:       90                      nop
    1705:       90                      nop
    1706:       90                      nop
    1707:       90                      nop
    1708:       41 5f                   pop    %r15
    170a:       41 5e                   pop    %r14
    170c:       41 5d                   pop    %r13
    170e:       41 5c                   pop    %r12
    1710:       5b                      pop    %rbx
    1711:       5d                      pop    %rbp
    1712:       e9 00 00 00 00          jmp    1717 <__switch_to_asm+0x67>   =
   1713: R_X86_64_PLT32    __switch_to-0x4

.altinstr_replacement:

      3a:       49 c7 c4 10 00 00 00    mov    $0x10,%r12
      41:       e8 01 00 00 00          call   47 <.altinstr_replacement+0x47>
      46:       cc                      int3
      47:       e8 01 00 00 00          call   4d <.altinstr_replacement+0x4d>
      4c:       cc                      int3
      4d:       48 83 c4 10             add    $0x10,%rsp
      51:       49 ff cc                dec    %r12
      54:       75 eb                   jne    41 <.altinstr_replacement+0x41>
      56:       0f ae e8                lfence
      59:       65 48 c7 04 25 00 00 00 00 ff ff ff ff  movq   $0xfffffffffff=
fffff,%gs:0x0      5e: R_X86_64_32S        pcpu_hot+0x10

      66:       e8 01 00 00 00          call   6c <.altinstr_replacement+0x6c>
      6b:       cc                      int3
      6c:       48 83 c4 08             add    $0x8,%rsp
      70:       0f ae e8                lfence

As can be seen from the two alternatives, when overlaid, the NOP after
the shorter (starting at 66) coinsides with the call at 47, leading to
conflicting CFI state for that instruction.

By offsetting the shorter alternative by 2 bytes, this alignment is
undone.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org> # build only
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net> # compile and run
Link: https://lore.kernel.org/r/20230208172245.783099843@infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nosp=
ec-branch.h
index e04313e..3ef70e5 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -261,7 +261,7 @@
 .macro FILL_RETURN_BUFFER reg:req nr:req ftr:req ftr2=3DALT_NOT(X86_FEATURE_=
ALWAYS)
 	ALTERNATIVE_2 "jmp .Lskip_rsb_\@", \
 		__stringify(__FILL_RETURN_BUFFER(\reg,\nr)), \ftr, \
-		__stringify(__FILL_ONE_RETURN), \ftr2
+		__stringify(nop;nop;__FILL_ONE_RETURN), \ftr2
=20
 .Lskip_rsb_\@:
 .endm
