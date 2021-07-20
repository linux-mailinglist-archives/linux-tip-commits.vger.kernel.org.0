Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8262C3CF8EA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jul 2021 13:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhGTK47 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Jul 2021 06:56:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbhGTK4w (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Jul 2021 06:56:52 -0400
Date:   Tue, 20 Jul 2021 11:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626781039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BzdAJmqWFDGPlX1pCwG3w6m/UxKMwlRCAmulfK4Lda0=;
        b=VfTaw4vCRUogxm6IuOVS7RfACbHr1NrIAfLDujMp5pjJHjyacKQ8uVd2ojO2G+3XYgS/Up
        aG5OLLMwVhSWs7JDskDoHUunuRUVxCIKTX51zrSIJF+q7NyarOWQOz7aImnzmOWnHcBpGU
        VHdbXMTSPWkb3cLUb2Kyh+BHTKJDnGkJsyumh8U61GA0MjJ07zhteT+2d6nBflUqWGbFiJ
        bY8ldke/gdBKrbj/cmejzNXNeN5aoDt4ze93GgYTLDHseh46DTAzR3dRnO6kHQM7k8nNRQ
        yDTVKyz+H0ygLff/lPqsDuP+DT+UFQZ3QppXj0yfMJDSQMJTE/9tZAyZl2qV1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626781039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BzdAJmqWFDGPlX1pCwG3w6m/UxKMwlRCAmulfK4Lda0=;
        b=I3P0q0ADBRPiwveRpCpYtoU+hN9QH5mZRQeHvQMt8vUUFITrpk4toU8RX65/Sw19L0dQSL
        GMB6h2tuxNfA9BCg==
From:   "tip-bot2 for Atish Patra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Fix the efi_load_initrd function description
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162678103854.395.2517207053400940703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     947228cb9f1a2c69a5da5279c48f02bb4f49ce32
Gitweb:        https://git.kernel.org/tip/947228cb9f1a2c69a5da5279c48f02bb4f49ce32
Author:        Atish Patra <atish.patra@wdc.com>
AuthorDate:    Fri, 02 Jul 2021 12:10:44 -07:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 16 Jul 2021 18:18:15 +02:00

efi/libstub: Fix the efi_load_initrd function description

The soft_limit and hard_limit in the function efi_load_initrd describes
the preferred and max address of initrd loading location respectively.
However, the description wrongly describes it as the size of the
allocated memory.

Fix the function description.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index aa8da0a..ae87dde 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -630,8 +630,8 @@ efi_status_t efi_load_initrd_cmdline(efi_loaded_image_t *image,
  * @image:	EFI loaded image protocol
  * @load_addr:	pointer to loaded initrd
  * @load_size:	size of loaded initrd
- * @soft_limit:	preferred size of allocated memory for loading the initrd
- * @hard_limit:	minimum size of allocated memory
+ * @soft_limit:	preferred address for loading the initrd
+ * @hard_limit:	upper limit address for loading the initrd
  *
  * Return:	status code
  */
