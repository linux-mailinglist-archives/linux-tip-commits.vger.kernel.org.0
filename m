Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189393656B3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhDTKsB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:48:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52042 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbhDTKri (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:38 -0400
Date:   Tue, 20 Apr 2021 10:47:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hO3L9oBlV/YbeXsS3BIE38EZYP4UchV8LdZugC9akI8=;
        b=o9XI3KvqkfbpkQuRPXVc98vAaO9hlP5+3dKTuGnMYPl+aqBbdS/mrO3OTG9I8LqtmLIteP
        yNEAC+A1+HI9a0zTZRYd3+WwxblB319PTeOGGyIHbwif9+UCbV1Ldodll4+JrCcKypY8/8
        TD8LpSgHAyWyPjpyCKp4sX8KMgi0PEx5lQdx0iDB69RicVN2rbhvVugf7Vly3/OwTwnd1F
        y/Ba4wn2th6MsLq8TGn6/txWFwESb4j47lrByIIibYM6SWdL6RDn5Mu0FQ3BhoeJmebm+M
        rU8MVfV1EZsz0DCLotBCKkAgJjfY+uZ5qVhItEUlsZEySs7doKaUFr56lqKeXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hO3L9oBlV/YbeXsS3BIE38EZYP4UchV8LdZugC9akI8=;
        b=0I35IxTUX6s25NkwjqcQ9QvNMq7ypPU0vGym3bBjbYohNR7rM7Ldrez63lOWouqZ/qqqFm
        /Z4Han5MxvwpE2Bg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/crypto/crc32c-pcl-intel: Standardize jump table
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5357a039def90b8ef6b5874ef12cda008ecf18ba.1614182415.git.jpoimboe@redhat.com>
References: <5357a039def90b8ef6b5874ef12cda008ecf18ba.1614182415.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <161891562305.29796.4322115593109629466.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2b02ed55482a1c5c310a7f53707292fcf1601e7a
Gitweb:        https://git.kernel.org/tip/2b02ed55482a1c5c310a7f53707292fcf1601e7a
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 10:29:19 -06:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 19 Apr 2021 12:36:34 -05:00

x86/crypto/crc32c-pcl-intel: Standardize jump table

Simplify the jump table code so that it resembles a compiler-generated
table.

This enables ORC unwinding by allowing objtool to follow all the
potential code paths.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/r/5357a039def90b8ef6b5874ef12cda008ecf18ba.1614182415.git.jpoimboe@redhat.com
---
 arch/x86/crypto/crc32c-pcl-intel-asm_64.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
index 884dc76..ac1f303 100644
--- a/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
+++ b/arch/x86/crypto/crc32c-pcl-intel-asm_64.S
@@ -53,7 +53,7 @@
 .endm
 
 .macro JMPTBL_ENTRY i
-.word crc_\i - crc_array
+.quad crc_\i
 .endm
 
 .macro JNC_LESS_THAN j
@@ -168,10 +168,7 @@ continue_block:
 	xor     crc2, crc2
 
 	## branch into array
-	lea	jump_table(%rip), %bufp
-	movzwq  (%bufp, %rax, 2), len
-	lea	crc_array(%rip), %bufp
-	lea     (%bufp, len, 1), %bufp
+	mov	jump_table(,%rax,8), %bufp
 	JMP_NOSPEC bufp
 
 	################################################################
