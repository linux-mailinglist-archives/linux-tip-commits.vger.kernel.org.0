Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC84D2D59AD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 12:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbgLJLun (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 06:50:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53406 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLJLuh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 06:50:37 -0500
Date:   Thu, 10 Dec 2020 11:49:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BA7KlfOg2DsYkIP2mLYhQatYBgcHVmtHGkOv9xzCu8k=;
        b=Sp/amVryuol5fatGyrXiVm8h9XCgTKJh2Rq55U4xHIg8+49pbPOrfHPc+NlmZKw7eZsjA1
        V+I7j0kMD8Sgz8z3JjyqGTDk2nvXO2XeNTy5I+LSUFa1sMFTmvn1/acoQJDavI7DklLVDb
        aYRWiByhk47HgjjriOtMr6bg9jvYrOwtM7fVAaPrdjLoNA1Qa7+Se6Dn2mCjBj1zyiP6kD
        1SAiiBNvcAbzTTT+A4VArL8bBs5n3e5jWmHD7ptxHy+vkDBa8N6g8QgxFPvN9r63eJN/CK
        4JYzdeY8gej7va45N1kdUpB2Uv6fnd6XBuPUay6ujKlYYOg5HqeoeKVSbnCWAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BA7KlfOg2DsYkIP2mLYhQatYBgcHVmtHGkOv9xzCu8k=;
        b=2KdojQ+FHCEptHZtts83btYa6zstN/8+U+Dm7wWkLh4cD3RE1XJjwE9g9uAUQFjMEtg2WD
        0rEXJzn+/MODeeBA==
From:   "tip-bot2 for Heinrich Schuchardt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/efi_test: read RuntimeServicesSupported
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Colin Ian King <colin.king@canonical.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127192051.1430-1-xypron.glpk@gmx.de>
References: <20201127192051.1430-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Message-ID: <160760098968.3364.7658260181933543462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     ff20661bb54cd57a18207b33cc57eb8d5c758a86
Gitweb:        https://git.kernel.org/tip/ff20661bb54cd57a18207b33cc57eb8d5c758a86
Author:        Heinrich Schuchardt <xypron.glpk@gmx.de>
AuthorDate:    Fri, 27 Nov 2020 20:20:51 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 09 Dec 2020 08:37:27 +01:00

efi/efi_test: read RuntimeServicesSupported

Since the UEFI 2.8A specification the UEFI enabled firmware provides a
configuration table EFI_RT_PROPERTIES_TABLE which indicates which runtime
services are enabled. The EFI stub reads this table and saves the value of
the field RuntimeServicesSupported internally.

The Firmware Test Suite requires the value to determine if UEFI runtime
services are correctly implemented.

With this patch an IOCTL call is provided to read the value of the field
RuntimeServicesSupported, e.g.

    #define EFI_RUNTIME_GET_SUPPORTED_MASK \
            _IOR('p', 0x0C, unsigned int)
    unsigned int mask;
    fd = open("/dev/efi_test", O_RDWR);
    ret = ioctl(fd, EFI_RUNTIME_GET_SUPPORTED_MASK, &mask);

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Link: https://lore.kernel.org/r/20201127192051.1430-1-xypron.glpk@gmx.de
Acked-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Ivan Hu <ivan.hu@canonical.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/test/efi_test.c | 16 ++++++++++++++++
 drivers/firmware/efi/test/efi_test.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
index ddf9eae..47d67bb 100644
--- a/drivers/firmware/efi/test/efi_test.c
+++ b/drivers/firmware/efi/test/efi_test.c
@@ -663,6 +663,19 @@ out:
 	return rv;
 }
 
+static long efi_runtime_get_supported_mask(unsigned long arg)
+{
+	unsigned int __user *supported_mask;
+	int rv = 0;
+
+	supported_mask = (unsigned int *)arg;
+
+	if (put_user(efi.runtime_supported_mask, supported_mask))
+		rv = -EFAULT;
+
+	return rv;
+}
+
 static long efi_test_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
@@ -699,6 +712,9 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
 
 	case EFI_RUNTIME_RESET_SYSTEM:
 		return efi_runtime_reset_system(arg);
+
+	case EFI_RUNTIME_GET_SUPPORTED_MASK:
+		return efi_runtime_get_supported_mask(arg);
 	}
 
 	return -ENOTTY;
diff --git a/drivers/firmware/efi/test/efi_test.h b/drivers/firmware/efi/test/efi_test.h
index f2446aa..117349e 100644
--- a/drivers/firmware/efi/test/efi_test.h
+++ b/drivers/firmware/efi/test/efi_test.h
@@ -118,4 +118,7 @@ struct efi_resetsystem {
 #define EFI_RUNTIME_RESET_SYSTEM \
 	_IOW('p', 0x0B, struct efi_resetsystem)
 
+#define EFI_RUNTIME_GET_SUPPORTED_MASK \
+	_IOR('p', 0x0C, unsigned int)
+
 #endif /* _DRIVERS_FIRMWARE_EFI_TEST_H_ */
