Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F81B8D76
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Apr 2020 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDZHeH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Apr 2020 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726113AbgDZHeH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Apr 2020 03:34:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D29FC061A0C;
        Sun, 26 Apr 2020 00:34:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSbnc-0000Zr-Qr; Sun, 26 Apr 2020 09:34:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6D1781C0178;
        Sun, 26 Apr 2020 09:34:00 +0200 (CEST)
Date:   Sun, 26 Apr 2020 07:33:59 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] objtool: Fix infinite loop in for_offset_range()
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <02b719674b031800b61e33c30b2e823183627c19.1587842122.git.jpoimboe@redhat.com>
References: <02b719674b031800b61e33c30b2e823183627c19.1587842122.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158788643996.28353.6941709693355737939.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     53fb6e990d782ded62d7c76d566e107c03393b74
Gitweb:        https://git.kernel.org/tip/53fb6e990d782ded62d7c76d566e107c03393b74
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Sat, 25 Apr 2020 14:19:01 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 26 Apr 2020 09:28:14 +02:00

objtool: Fix infinite loop in for_offset_range()

Randy reported that objtool got stuck in an infinite loop when
processing drivers/i2c/busses/i2c-parport.o.  It was caused by the
following code:

  00000000000001fd <line_set>:
   1fd:	48 b8 00 00 00 00 00	movabs $0x0,%rax
   204:	00 00 00
			1ff: R_X86_64_64	.rodata-0x8
   207:	41 55                	push   %r13
   209:	41 89 f5             	mov    %esi,%r13d
   20c:	41 54                	push   %r12
   20e:	49 89 fc             	mov    %rdi,%r12
   211:	55                   	push   %rbp
   212:	48 89 d5             	mov    %rdx,%rbp
   215:	53                   	push   %rbx
   216:	0f b6 5a 01          	movzbl 0x1(%rdx),%ebx
   21a:	48 8d 34 dd 00 00 00 	lea    0x0(,%rbx,8),%rsi
   221:	00
			21e: R_X86_64_32S	.rodata
   222:	48 89 f1             	mov    %rsi,%rcx
   225:	48 29 c1             	sub    %rax,%rcx

find_jump_table() saw the .rodata reference and tried to find a jump
table associated with it (though there wasn't one).  The -0x8 rela
addend is unusual.  It caused find_jump_table() to send a negative
table_offset (unsigned 0xfffffffffffffff8) to find_rela_by_dest().

The negative offset should have been harmless, but it actually threw
for_offset_range() for a loop... literally.  When the mask value got
incremented past the end value, it also wrapped to zero, causing the
loop exit condition to remain true forever.

Prevent this scenario from happening by ensuring the incremented value
is always >= the starting value.

Fixes: 74b873e49d92 ("objtool: Optimize find_rela_by_dest_range()")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Julien Thierry <jthierry@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/02b719674b031800b61e33c30b2e823183627c19.1587842122.git.jpoimboe@redhat.com
---
 tools/objtool/elf.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
index ebbb10c..c227a2e 100644
--- a/tools/objtool/elf.h
+++ b/tools/objtool/elf.h
@@ -87,9 +87,10 @@ struct elf {
 #define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
 #define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
 
-#define for_offset_range(_offset, _start, _end)		\
-	for (_offset = ((_start) & OFFSET_STRIDE_MASK);	\
-	     _offset <= ((_end) & OFFSET_STRIDE_MASK);	\
+#define for_offset_range(_offset, _start, _end)			\
+	for (_offset = ((_start) & OFFSET_STRIDE_MASK);		\
+	     _offset >= ((_start) & OFFSET_STRIDE_MASK) &&	\
+	     _offset <= ((_end) & OFFSET_STRIDE_MASK);		\
 	     _offset += OFFSET_STRIDE)
 
 static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
