Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E04584CB7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2019 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfHGNTS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Aug 2019 09:19:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43121 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbfHGNTS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Aug 2019 09:19:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x77DJBf72695406
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 7 Aug 2019 06:19:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x77DJBf72695406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565183952;
        bh=MnPPyHF/3DqdV3ltYydc8rzca+L7XLy3cRk7ClNghso=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=RkOGCASfqMd0l1Fi/Z/ojE/MbkM9vDdcu4/U7qhKNrUPtIytylR8uK0Yy8Yx6NW+I
         alDS3PRZmz0Wb59H84znfKjbjnC1tp9RZpFSXsNKFnHua0jFewZBozOEicfXyNp5dh
         1VTgXjHQoI3wTm2gzcehL12hUOs1czXC/zw1GpX7x++Fmn3DRkqcnWHpOVnN4YxZnt
         kgikS5Sx2OzPJ1N1vU7nCtUEwZvPryu0Be9miGRffrknSvmrWvKQew80B+QRe9zHgH
         hs/Ndmh4yUw+DTQ3Mk4yWLeJOdhdzSeoLoXLOd42OUy59C/RrhHYAhnqpW6xqXsza2
         dwyc0mQzTOXRQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x77DJAs62695403;
        Wed, 7 Aug 2019 06:19:10 -0700
Date:   Wed, 7 Aug 2019 06:19:10 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Hubbard <tipbot@zytor.com>
Message-ID: <tip-610666f0581557944c3abec93a7c125b8303442c@git.kernel.org>
Cc:     mingo@kernel.org, jhubbard@nvidia.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jhubbard@nvidia.com, mingo@kernel.org
In-Reply-To: <20190731054627.5627-2-jhubbard@nvidia.com>
References: <20190731054627.5627-2-jhubbard@nvidia.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Save fields explicitly, zero out
 everything else
Git-Commit-ID: 610666f0581557944c3abec93a7c125b8303442c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  610666f0581557944c3abec93a7c125b8303442c
Gitweb:     https://git.kernel.org/tip/610666f0581557944c3abec93a7c125b8303442c
Author:     John Hubbard <jhubbard@nvidia.com>
AuthorDate: Tue, 30 Jul 2019 22:46:27 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 7 Aug 2019 15:16:04 +0200

x86/boot: Save fields explicitly, zero out everything else

Recent gcc compilers (gcc 9.1) generate warnings about an
out of bounds memset, if you trying memset across several fields
of a struct. This generated a couple of warnings on x86_64 builds.

Fix this by explicitly saving the fields in struct boot_params
that are intended to be preserved, and zeroing all the rest.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190731054627.5627-2-jhubbard@nvidia.com

---
 arch/x86/include/asm/bootparam_utils.h | 63 ++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 101eb944f13c..f5e90a849bca 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -18,6 +18,20 @@
  * Note: efi_info is commonly left uninitialized, but that field has a
  * private magic, so it is better to leave it unchanged.
  */
+
+#define sizeof_mbr(type, member) ({ sizeof(((type *)0)->member); })
+
+#define BOOT_PARAM_PRESERVE(struct_member)				\
+	{								\
+		.start = offsetof(struct boot_params, struct_member),	\
+		.len   = sizeof_mbr(struct boot_params, struct_member),	\
+	}
+
+struct boot_params_to_save {
+	unsigned int start;
+	unsigned int len;
+};
+
 static void sanitize_boot_params(struct boot_params *boot_params)
 {
 	/* 
@@ -35,21 +49,40 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 	 * problems again.
 	 */
 	if (boot_params->sentinel) {
-		/* fields in boot_params are left uninitialized, clear them */
-		boot_params->acpi_rsdp_addr = 0;
-		memset(&boot_params->ext_ramdisk_image, 0,
-		       (char *)&boot_params->efi_info -
-			(char *)&boot_params->ext_ramdisk_image);
-		memset(&boot_params->kbd_status, 0,
-		       (char *)&boot_params->hdr -
-		       (char *)&boot_params->kbd_status);
-		memset(&boot_params->_pad7[0], 0,
-		       (char *)&boot_params->edd_mbr_sig_buffer[0] -
-			(char *)&boot_params->_pad7[0]);
-		memset(&boot_params->_pad8[0], 0,
-		       (char *)&boot_params->eddbuf[0] -
-			(char *)&boot_params->_pad8[0]);
-		memset(&boot_params->_pad9[0], 0, sizeof(boot_params->_pad9));
+		static struct boot_params scratch;
+		char *bp_base = (char *)boot_params;
+		char *save_base = (char *)&scratch;
+		int i;
+
+		const struct boot_params_to_save to_save[] = {
+			BOOT_PARAM_PRESERVE(screen_info),
+			BOOT_PARAM_PRESERVE(apm_bios_info),
+			BOOT_PARAM_PRESERVE(tboot_addr),
+			BOOT_PARAM_PRESERVE(ist_info),
+			BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
+			BOOT_PARAM_PRESERVE(hd0_info),
+			BOOT_PARAM_PRESERVE(hd1_info),
+			BOOT_PARAM_PRESERVE(sys_desc_table),
+			BOOT_PARAM_PRESERVE(olpc_ofw_header),
+			BOOT_PARAM_PRESERVE(efi_info),
+			BOOT_PARAM_PRESERVE(alt_mem_k),
+			BOOT_PARAM_PRESERVE(scratch),
+			BOOT_PARAM_PRESERVE(e820_entries),
+			BOOT_PARAM_PRESERVE(eddbuf_entries),
+			BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
+			BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
+			BOOT_PARAM_PRESERVE(e820_table),
+			BOOT_PARAM_PRESERVE(eddbuf),
+		};
+
+		memset(&scratch, 0, sizeof(scratch));
+
+		for (i = 0; i < ARRAY_SIZE(to_save); i++) {
+			memcpy(save_base + to_save[i].start,
+			       bp_base + to_save[i].start, to_save[i].len);
+		}
+
+		memcpy(boot_params, save_base, sizeof(*boot_params));
 	}
 }
 
