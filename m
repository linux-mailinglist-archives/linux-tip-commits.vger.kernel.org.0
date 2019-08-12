Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB08A402
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfHLRHe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 13:07:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50197 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfHLRHd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 13:07:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CH7E4G994216
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 10:07:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CH7E4G994216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565629635;
        bh=I890kUx1pDO0HdPKM65T9tG+ZWIkp3p7pWJoeNUpqTM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=5FmKoNkEgvPG01wXLpHusOZYtltVTuIyUfSrmBiAyNJHS7uLhBt7K4b4NOd8cPJr9
         o0wg/TWqAYmqyJnlKjqi0LxMTOrk+8am9R0zLeidYRC0yqfqd1+wbNFAvSt2EGMXN1
         73eRszWiZcwe9clgO5PzgUobZh4X4XVJXDbun551nV0nJGtpHYlKblcqbV3DQDkBGz
         Rfvdw3rw/mUbicexOmGNLEm0VKlnuhwbvNHDoGeXY6t3xSNKfNniHxP2RahfnQSF/v
         OWYQEMxgXcCJhJo+YMZpJKx1t0CC7Lp/aHCGVnyE6h90HJYO6VyGhc0761ZuF0V5Gf
         NUvdIVStaOMDg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CH7DBG994213;
        Mon, 12 Aug 2019 10:07:13 -0700
Date:   Mon, 12 Aug 2019 10:07:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaofei Tan <tipbot@zytor.com>
Message-ID: <tip-b194a77fcc4001dc40aecdd15d249648e8a436d1@git.kernel.org>
Cc:     james.morse@arm.com, mingo@kernel.org, ard.biesheuvel@linaro.org,
        tglx@linutronix.de, hpa@zytor.com, tanxiaofei@huawei.com
Reply-To: james.morse@arm.com, tanxiaofei@huawei.com, mingo@kernel.org,
          ard.biesheuvel@linaro.org, tglx@linutronix.de, hpa@zytor.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: cper: print AER info of PCIe fatal error
Git-Commit-ID: b194a77fcc4001dc40aecdd15d249648e8a436d1
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

Commit-ID:  b194a77fcc4001dc40aecdd15d249648e8a436d1
Gitweb:     https://git.kernel.org/tip/b194a77fcc4001dc40aecdd15d249648e8a436d1
Author:     Xiaofei Tan <tanxiaofei@huawei.com>
AuthorDate: Fri, 26 Jul 2019 09:43:37 +0800
Committer:  Ard Biesheuvel <ard.biesheuvel@linaro.org>
CommitDate: Mon, 12 Aug 2019 12:06:23 +0300

efi: cper: print AER info of PCIe fatal error

AER info of PCIe fatal error is not printed in the current driver.
Because APEI driver will panic directly for fatal error, and can't
run to the place of printing AER info.

An example log is as following:
{763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
{763}[Hardware Error]: event severity: fatal
{763}[Hardware Error]:  Error 0, type: fatal
{763}[Hardware Error]:   section_type: PCIe error
{763}[Hardware Error]:   port_type: 0, PCIe end point
{763}[Hardware Error]:   version: 4.0
{763}[Hardware Error]:   command: 0x0000, status: 0x0010
{763}[Hardware Error]:   device_id: 0000:82:00.0
{763}[Hardware Error]:   slot: 0
{763}[Hardware Error]:   secondary_bus: 0x00
{763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
{763}[Hardware Error]:   class_code: 000002
Kernel panic - not syncing: Fatal hardware error!

This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
cper_print_aer() call out of interrupt context")'. To fix this issue,
this patch adds print of AER info in cper_print_pcie() for fatal error.

Here is the example log after this patch applied:
{24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
{24}[Hardware Error]: event severity: fatal
{24}[Hardware Error]:  Error 0, type: fatal
{24}[Hardware Error]:   section_type: PCIe error
{24}[Hardware Error]:   port_type: 0, PCIe end point
{24}[Hardware Error]:   version: 4.0
{24}[Hardware Error]:   command: 0x0546, status: 0x4010
{24}[Hardware Error]:   device_id: 0000:01:00.0
{24}[Hardware Error]:   slot: 0
{24}[Hardware Error]:   secondary_bus: 0x00
{24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
{24}[Hardware Error]:   class_code: 000002
{24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
{24}[Hardware Error]:   aer_uncor_severity: 0x00062010
{24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
Kernel panic - not syncing: Fatal hardware error!

Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of interrupt context")
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
[ardb: put parens around terms of && operator]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/cper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 8fa977c7861f..addf0749dd8b 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -390,6 +390,21 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk(
 	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
 	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
+
+	/* Fatal errors call __ghes_panic() before AER handler prints this */
+	if ((pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) &&
+	    (gdata->error_severity & CPER_SEV_FATAL)) {
+		struct aer_capability_regs *aer;
+
+		aer = (struct aer_capability_regs *)pcie->aer_info;
+		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
+		       pfx, aer->uncor_status, aer->uncor_mask);
+		printk("%saer_uncor_severity: 0x%08x\n",
+		       pfx, aer->uncor_severity);
+		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
+		       aer->header_log.dw0, aer->header_log.dw1,
+		       aer->header_log.dw2, aer->header_log.dw3);
+	}
 }
 
 static void cper_print_tstamp(const char *pfx,
