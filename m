Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18226306443
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344492AbhA0Tju (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhA0Tbz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1F2C061756;
        Wed, 27 Jan 2021 11:31:14 -0800 (PST)
Date:   Wed, 27 Jan 2021 19:31:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IrbS3K0K/nzdIC+woarIyGiZOo2IasWK7PpwMdP5Wy4=;
        b=jsiojZ5uxZavtezX84MeXLTnOKnexedLqmgfvczJEux2jXYFKa2GlhalvNP5O/14EI2bAv
        uu09pucbKHeoXqAy36Wv/Q0vARG3T76rg/uDv0L+Ag4080632LTLvYnZhv5+3QtLr/YyHv
        zZvwCKqgK/5wpyNWIF8oloXllJBZ7aAEqCO75Oc4xDyGdgliQI9ELSNkERmaV27gm1L87u
        EzolxKagqnGuQDotDd10iNylUZu6mzH8pAGTF/rgi5U5Zlg9rSxQX1HVX8xj4dlYnsiQWy
        4oUDRbwmXUrPby+H24MaF18OW6i/fwEt7AcUIjK36PX99y6By3OmQVxlG1RR8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IrbS3K0K/nzdIC+woarIyGiZOo2IasWK7PpwMdP5Wy4=;
        b=gce2gpJRLAkJBd2L4twP9UjvwcSFvNQMs2K5w5uZ11kQ/UVzHSvWnna5R/G3vqAhy4qsCA
        onggHvVuWHDl4QDw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/libstub: move TPM related prototypes into efistub.h
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161177587062.23325.2346312864107932390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     3820749ddcee694abfd5ae6cabc18aaab11eab34
Gitweb:        https://git.kernel.org/tip/3820749ddcee694abfd5ae6cabc18aaab11eab34
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 02 Nov 2020 11:51:10 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 19 Jan 2021 17:57:15 +01:00

efi/libstub: move TPM related prototypes into efistub.h

Move TPM related definitions that are only used in the EFI stub into
efistub.h, which is a local header.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efistub.h |  9 +++++++++
 include/linux/efi.h                    |  9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2b7438b..cde0a2e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -849,4 +849,13 @@ void efi_handle_post_ebs_state(void);
 
 enum efi_secureboot_mode efi_get_secureboot(void);
 
+#ifdef CONFIG_RESET_ATTACK_MITIGATION
+void efi_enable_reset_attack_mitigation(void);
+#else
+static inline void
+efi_enable_reset_attack_mitigation(void) { }
+#endif
+
+void efi_retrieve_tpm2_eventlog(void);
+
 #endif
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2537a24..8710f57 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1104,13 +1104,6 @@ enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
 	return efi_secureboot_mode_enabled;
 }
 
-#ifdef CONFIG_RESET_ATTACK_MITIGATION
-void efi_enable_reset_attack_mitigation(void);
-#else
-static inline void
-efi_enable_reset_attack_mitigation(void) { }
-#endif
-
 #ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
 void efi_check_for_embedded_firmwares(void);
 #else
@@ -1119,8 +1112,6 @@ static inline void efi_check_for_embedded_firmwares(void) { }
 
 efi_status_t efi_random_get_seed(void);
 
-void efi_retrieve_tpm2_eventlog(void);
-
 /*
  * Arch code can implement the following three template macros, avoiding
  * reptition for the void/non-void return cases of {__,}efi_call_virt():
