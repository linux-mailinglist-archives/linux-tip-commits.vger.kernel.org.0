Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB77226F834
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgIRIa6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIRIaz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC663C06174A;
        Fri, 18 Sep 2020 01:30:54 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:30:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4P9F8MTT9HBIDMHD1YyUVI8yOG1iPJXxsCovMWzSOh8=;
        b=paTKCtQb5BA4OWv2nEfp17qGnI+w82ivB/j4eI962nJfW5RuuanwVlXHWHMTQ+QjD3Le9v
        XqGeI4hDXcJXnHSBDrEqNT0Af04GEdp1o1RkO4SEGTewgTcWBLZKInJqyo1QSvDsOoqQ+i
        Z3bVOgO30ZkZoQ3H/1++og6uE9QhZqkw/87WQUKFS0gDBvtjPxGI4jOD8VGHyJVEu5yYHG
        cy9bwdZQ0aet+z74ctbSrJB96rG0PM7+oPK3xV3jOhc7Mpd6G12hPV9J98ppwcA+OFTbm+
        mkHyVa/uCKumz6Ev9KtFswFsTzVOzvUnaw/+lHxb8b7vDrRC3eQ48vriwwG0jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4P9F8MTT9HBIDMHD1YyUVI8yOG1iPJXxsCovMWzSOh8=;
        b=W2qgMpXFQa7Y/jyiGolnC3/pbjXW1kYvbktIqdD5bhTj9LSb69dqP19D3DX1LS90V8Aw+1
        x81bT9l8/Lh/rFDg==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: Add efi_warn and *_once logging helpers
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200914213535.933454-1-nivedita@alum.mit.edu>
References: <20200914213535.933454-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160041785278.15536.469289056663350362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     c1df5e0c5796f775e60d1aec0b52f6d03d66ccd4
Gitweb:        https://git.kernel.org/tip/c1df5e0c5796f775e60d1aec0b52f6d03d66ccd4
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 14 Sep 2020 17:35:34 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:53:42 +03:00

efi/libstub: Add efi_warn and *_once logging helpers

Add an efi_warn logging helper for warnings, and implement an analog of
printk_once for once-only logging.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Link: https://lore.kernel.org/r/20200914213535.933454-1-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 27cdcb1..9ea87a2 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -52,11 +52,34 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 
 #define efi_info(fmt, ...) \
 	efi_printk(KERN_INFO fmt, ##__VA_ARGS__)
+#define efi_warn(fmt, ...) \
+	efi_printk(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
 #define efi_err(fmt, ...) \
 	efi_printk(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
 #define efi_debug(fmt, ...) \
 	efi_printk(KERN_DEBUG "DEBUG: " fmt, ##__VA_ARGS__)
 
+#define efi_printk_once(fmt, ...) 		\
+({						\
+	static bool __print_once;		\
+	bool __ret_print_once = !__print_once;	\
+						\
+	if (!__print_once) {			\
+		__print_once = true;		\
+		efi_printk(fmt, ##__VA_ARGS__);	\
+	}					\
+	__ret_print_once;			\
+})
+
+#define efi_info_once(fmt, ...) \
+	efi_printk_once(KERN_INFO fmt, ##__VA_ARGS__)
+#define efi_warn_once(fmt, ...) \
+	efi_printk_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
+#define efi_err_once(fmt, ...) \
+	efi_printk_once(KERN_ERR "ERROR: " fmt, ##__VA_ARGS__)
+#define efi_debug_once(fmt, ...) \
+	efi_printk_once(KERN_DEBUG "DEBUG: " fmt, ##__VA_ARGS__)
+
 /* Helper macros for the usual case of using simple C variables: */
 #ifndef fdt_setprop_inplace_var
 #define fdt_setprop_inplace_var(fdt, node_offset, name, var) \
