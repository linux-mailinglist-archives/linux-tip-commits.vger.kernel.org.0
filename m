Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A0043E23A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Oct 2021 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhJ1NcC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Oct 2021 09:32:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhJ1NcC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Oct 2021 09:32:02 -0400
Date:   Thu, 28 Oct 2021 13:29:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635427774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7RMP0P0fqRHDVGvukHeKY+eqDsXta5wVjUj6pXE/Lg=;
        b=QEzdJRKzg5a36Oer7R385oUaIwrr3pqJQcTL14q8sheKu+rJam7UOTNbb488m1oJAwFXrR
        04ufUXs7b3rCaLkoUBkn0/xaiGw6ikGLljmZjVpGbLGGJyKYmNSTGVwgTkCVK9FVGZY3hG
        Pncs2l+Oi2VIPpp6uZ1uaWv/hLCl/W6X/SnNCEbubawSKLUioazviGidPeAvRWn0GJYg0d
        x/Xwak2bpgJIKODj6L6ITZF/5mfPB0F2Ba1HKZ+nKDZ6yGwEmBfHIQe5oelfsTxC0ob6EV
        sR7SVCi9zqs0+syDhLnTtMs9VIlU2pj8/GfrGhNlOtLCs8fTDwUQVmKZZ+Xtbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635427774;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7RMP0P0fqRHDVGvukHeKY+eqDsXta5wVjUj6pXE/Lg=;
        b=GFaCKE8jc8Oip40GUoGNpL63q/UwbMKEi+YrL1OS5HherwBxcMyXQV7toiG6bX2vqCH8U/
        3c1EH1qa+4kC/1DQ==
From:   "tip-bot2 for Kristen Carlson Accardi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211013175742.1197608-5-keescook@chromium.org>
References: <20211013175742.1197608-5-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163542777304.626.17338682230666549954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ca136cac37eb51649d52d5bc4271c55e30ed354c
Gitweb:        https://git.kernel.org/tip/ca136cac37eb51649d52d5bc4271c55e30ed354c
Author:        Kristen Carlson Accardi <kristen@linux.intel.com>
AuthorDate:    Wed, 13 Oct 2021 10:57:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 27 Oct 2021 11:07:59 +02:00

vmlinux.lds.h: Have ORC lookup cover entire _etext - _stext

When using -ffunction-sections to place each function in its own text
section (so it can be randomized at load time in the future FGKASLR
series), the linker will place most of the functions into separate .text.*
sections. SIZEOF(.text) won't work here for calculating the ORC lookup
table size, so the total text size must be calculated to include .text
AND all .text.* sections.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
[ alobakin: move it to vmlinux.lds.h and make arch-indep ]
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20211013175742.1197608-5-keescook@chromium.org
---
 include/asm-generic/vmlinux.lds.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f2984af..e823491 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -869,10 +869,11 @@
 		KEEP(*(.orc_unwind))					\
 		__stop_orc_unwind = .;					\
 	}								\
+	text_size = _etext - _stext;					\
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
 		orc_lookup = .;						\
-		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
+		. += (((text_size + LOOKUP_BLOCK_SIZE - 1) /		\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
 		orc_lookup_end = .;					\
 	}
