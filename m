Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECCB42ED18
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhJOJIb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbhJOJIa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:08:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3228AC061755;
        Fri, 15 Oct 2021 02:06:24 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:06:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634288782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/eVxqsQVyTjC/PcwEvhcWz3BPILOyelDj0flP1G5f9E=;
        b=Ivduiz9vWXyaCqIZPf6A41/zUSo5gzOrdq1Gf5oG1gZVtKxFF3rtIPN2wyrBvIqfCVlqAF
        NJB+n4XGEuDkqrjWXyg8mezGwgaJ357OKri3xKLkBJjzKy39e8rxLJaj3hJFmVbG3P84FG
        U0J/UuikJG3ztAoOTNNUM/TVx8h0zKkLLRgDMyxXSOs+QhDS9Lt6z+dBkzPXXzRGGmIBFl
        CfBBOrzp2YjehN3qtOaVYSIrXjro55SkKZIEzwo9utAHgBy6XlZzhSJGQa2FwdkzeXUD5c
        xnwxEXizfZDnE2epFHz2M+KrpmfDwJNhVg/bJdjDOZX7tY0/njL7I4AgNHUqzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634288782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/eVxqsQVyTjC/PcwEvhcWz3BPILOyelDj0flP1G5f9E=;
        b=kxpptLYEY+xaNMRT4WnGAL5XN/6MNOpMLUZ6aODMqxqfAzLkcV1HR6d91CIiZkkD28DIk4
        HEWDnzud+WCo+KAA==
From:   "tip-bot2 for Heinrich Schuchardt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Simplify "Exiting bootservices" message
Cc:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163428878191.25758.6671255894314776649.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     68c9cdf37a0456b7ba25a50b1ea8794f305da17f
Gitweb:        https://git.kernel.org/tip/68c9cdf37a0456b7ba25a50b1ea8794f305da17f
Author:        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
AuthorDate:    Sun, 29 Aug 2021 15:23:10 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 05 Oct 2021 13:05:58 +02:00

efi/libstub: Simplify "Exiting bootservices" message

The message

    "Exiting boot services and installing virtual address map...\n"

is even shown if we have efi=novamap on the command line or the firmware
does not provide EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP.

To avoid confusion just print

    "Exiting boot services...\n"

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/fdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 365c3a4..fe567be 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -271,7 +271,7 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 		return status;
 	}
 
-	efi_info("Exiting boot services and installing virtual address map...\n");
+	efi_info("Exiting boot services...\n");
 
 	map.map = &memory_map;
 	status = efi_allocate_pages(MAX_FDT_SIZE, new_fdt_addr, ULONG_MAX);
