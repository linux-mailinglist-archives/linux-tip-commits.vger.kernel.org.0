Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A789E9D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 14:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHLMlK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 08:41:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46441 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfHLMlK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 08:41:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CCeiuT907213
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 05:40:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CCeiuT907213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565613645;
        bh=6EJ1Y6U2Bpj16fxidRk8tEE7trYYoImAflL2stbAik4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=xyEE35RiEAVb5jAd4XJ7p/ONKZnR0xr3uXmtqp7pHJv9xd7t9Cm1z0rY9x49GYvqO
         55cmXYOpWIErdK7JDfNjx+PrSbouynS9TwO5R4Z/tRoe4ShqfTtTJqvV2WhMKKq/u+
         bM5q89sqeDqzmuz3wuYds76xGH2xNv3EY0rp6zPzMeP4gYOD1f2mMKvYGFAbr0CWL3
         GpjjrEOH3JHowwOZayCfdgk0X40yT37KRilCJGosCk4uR9TYVpDO9Ez06IHn58OZc8
         2jxx7AZXFWFic2jelbFqbTULKZa/dNKA38+Ig5J/GDX43DDw50CGXPSYVYplYL5P2t
         j9yZ+SXVwh/NQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CCeiBC907210;
        Mon, 12 Aug 2019 05:40:44 -0700
Date:   Mon, 12 Aug 2019 05:40:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hans de Goede <tipbot@zytor.com>
Message-ID: <tip-b61fbc887af7a13a1c90c84c1feaeb4c9780e1e2@git.kernel.org>
Cc:     hpa@zytor.com, ard.biesheuvel@linaro.org,
        jarkko.sakkinen@linux.intel.com, mingo@kernel.org,
        mjg59@google.com, hdegoede@redhat.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, ard.biesheuvel@linaro.org,
          jarkko.sakkinen@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, mjg59@google.com,
          hdegoede@redhat.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/urgent] efi-stub: Fix get_efi_config_table on mixed-mode
 setups
Git-Commit-ID: b61fbc887af7a13a1c90c84c1feaeb4c9780e1e2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  b61fbc887af7a13a1c90c84c1feaeb4c9780e1e2
Gitweb:     https://git.kernel.org/tip/b61fbc887af7a13a1c90c84c1feaeb4c9780e1e2
Author:     Hans de Goede <hdegoede@redhat.com>
AuthorDate: Wed, 7 Aug 2019 23:59:03 +0200
Committer:  Ard Biesheuvel <ard.biesheuvel@linaro.org>
CommitDate: Mon, 12 Aug 2019 11:58:35 +0300

efi-stub: Fix get_efi_config_table on mixed-mode setups

Fix get_efi_config_table using the wrong structs when booting a
64 bit kernel on 32 bit firmware.

Fixes: 82d736ac56d7 ("Abstract out support for locating an EFI config table")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-By: Matthew Garrett <mjg59@google.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 38 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 1db780c0f07b..3caae7f2cf56 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -927,17 +927,33 @@ fail:
 	return status;
 }
 
+#define GET_EFI_CONFIG_TABLE(bits)					\
+static void *get_efi_config_table##bits(efi_system_table_t *_sys_table,	\
+					efi_guid_t guid)		\
+{									\
+	efi_system_table_##bits##_t *sys_table;				\
+	efi_config_table_##bits##_t *tables;				\
+	int i;								\
+									\
+	sys_table = (typeof(sys_table))_sys_table;			\
+	tables = (typeof(tables))(unsigned long)sys_table->tables;	\
+									\
+	for (i = 0; i < sys_table->nr_tables; i++) {			\
+		if (efi_guidcmp(tables[i].guid, guid) != 0)		\
+			continue;					\
+									\
+		return (void *)(unsigned long)tables[i].table;		\
+	}								\
+									\
+	return NULL;							\
+}
+GET_EFI_CONFIG_TABLE(32)
+GET_EFI_CONFIG_TABLE(64)
+
 void *get_efi_config_table(efi_system_table_t *sys_table, efi_guid_t guid)
 {
-	efi_config_table_t *tables = (efi_config_table_t *)sys_table->tables;
-	int i;
-
-	for (i = 0; i < sys_table->nr_tables; i++) {
-		if (efi_guidcmp(tables[i].guid, guid) != 0)
-			continue;
-
-		return (void *)tables[i].table;
-	}
-
-	return NULL;
+	if (efi_is_64bit())
+		return get_efi_config_table64(sys_table, guid);
+	else
+		return get_efi_config_table32(sys_table, guid);
 }
