Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC85423FC6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Oct 2021 16:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhJFOIP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 10:08:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58466 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhJFOIP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 10:08:15 -0400
Date:   Wed, 06 Oct 2021 14:06:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633529181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TnqXDE+epmRCsb/NQwigc92wqJaLY9A6+4Ozd7SRXw=;
        b=aaJrKCFBtbFNaHnmLNM2mCeuidhqzM1i+KNpUYSFSb8KRYipfXBcwXrKjeQM3mK2Vuol4V
        lT+1k7y9lCYlFFMrJOhpULzFkDdi/wexhlYOMW7u4Bq+QEkBqc3iwpu4Ei/Gu/G3NImrB7
        rD56oOxkMIOb1HStjtFcHiwtDGdAXoIiQIZ/YkVVbZs/dmoIlk4eCaamPcl87/7KGPRaOK
        leCCCBlox2HSNVeYdBjbuGieiMRBeUoWAOJ1rXQzQs46p8xsU2shEVx6uClsN3904aJYlb
        xxrRmqRVJ074juuHBzOotXFWiib7TPDDG/oGRl7jNHDzyT92HTj81s6ylzuqTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633529181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7TnqXDE+epmRCsb/NQwigc92wqJaLY9A6+4Ozd7SRXw=;
        b=BCysXDsA7Q1aKbPNCpIFVTnBKLcBOVwdJAl2B3/phq0RYmEBwbOt8TNUf/Vt5llMMbwSDJ
        o1Etsvwv+w4IvuCg==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86: Fix misspelled Kconfig symbols
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210803113531.30720-7-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-7-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <163352918036.25758.5930935592079646342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     6bf8a55d8344df1f61a29b18c398bcdf3539e163
Gitweb:        https://git.kernel.org/tip/6bf8a55d8344df1f61a29b18c398bcdf3539e163
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Tue, 05 Oct 2021 21:48:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Oct 2021 21:48:30 +02:00

x86: Fix misspelled Kconfig symbols

Fix misspelled Kconfig symbols as detected by
scripts/checkkconfigsymbols.py.

 [ bp: Combine into a single patch. ]

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210803113531.30720-7-lukas.bulwahn@gmail.com
---
 arch/x86/include/asm/ia32.h      | 2 +-
 arch/x86/include/asm/irq_stack.h | 2 +-
 arch/x86/include/asm/page_32.h   | 2 +-
 arch/x86/include/asm/uaccess.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
index 2c5f786..fada857 100644
--- a/arch/x86/include/asm/ia32.h
+++ b/arch/x86/include/asm/ia32.h
@@ -68,6 +68,6 @@ extern void ia32_pick_mmap_layout(struct mm_struct *mm);
 
 #endif
 
-#endif /* !CONFIG_IA32_SUPPORT */
+#endif /* CONFIG_IA32_EMULATION */
 
 #endif /* _ASM_X86_IA32_H */
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562854c..8912492 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -58,7 +58,7 @@
  *     the output constraints to make the compiler aware that R11 cannot be
  *     reused after the asm() statement.
  *
- *     For builds with CONFIG_UNWIND_FRAME_POINTER ASM_CALL_CONSTRAINT is
+ *     For builds with CONFIG_UNWINDER_FRAME_POINTER, ASM_CALL_CONSTRAINT is
  *     required as well as this prevents certain creative GCC variants from
  *     misplacing the ASM code.
  *
diff --git a/arch/x86/include/asm/page_32.h b/arch/x86/include/asm/page_32.h
index 94dbd51..b13f848 100644
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -43,7 +43,7 @@ static inline void copy_page(void *to, void *from)
 {
 	memcpy(to, from, PAGE_SIZE);
 }
-#endif	/* CONFIG_X86_3DNOW */
+#endif	/* CONFIG_X86_USE_3DNOW */
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index c9fa7be..e7fc2c5 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -411,7 +411,7 @@ do {									\
 		     : [umem] "m" (__m(addr)),				\
 		       [efault] "i" (-EFAULT), "0" (err))
 
-#endif // CONFIG_CC_ASM_GOTO_OUTPUT
+#endif // CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 
 /* FIXME: this hack is definitely wrong -AK */
 struct __large_struct { unsigned long buf[100]; };
