Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6477C3FA508
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Aug 2021 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhH1Kij (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Aug 2021 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbhH1Kih (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Aug 2021 06:38:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ECCC061756;
        Sat, 28 Aug 2021 03:37:47 -0700 (PDT)
Date:   Sat, 28 Aug 2021 10:37:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630147064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z1MH+SPX7s30rIq5HTVkXckgHonnETEjsXmBd215+I0=;
        b=QXFYQFuMeE6koz+XvAuRb1x7ZGzECfb4W33kEWYqggi/VYNl1SheOCZ7IYYalxvqIrFwkb
        Vrs+aswMB78wIJ3RTZ0pWEVrocLsvXcNgYRqs1gaUm4R9tFoaTlq/oPTY9Qac2qkUbr3An
        gCHpY4p+yaTKhZyqByth3qdTXGeB9D9qiv2r1E0CQ8C+Z1IepOwcodD2y6/wg7KIGaSooc
        /0Sia2m82aDgpWwPeBqGla+4ih8zh0jg3Bh3p/rkH1ZNOCAzuv2Uoaz3rD7D391A8O1qKu
        oGv2ZbuTGasjRoM8OjgXAT7c9AQ9OBWRErXOEEW/llHyZGBWJV8+gB/lHjcXZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630147064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z1MH+SPX7s30rIq5HTVkXckgHonnETEjsXmBd215+I0=;
        b=3ivK08grzrRh0KlTyAV/YnQuyFYZjgxj65Z+joKwyjSBLaiEBbzf2oD8utJ6kXic2WAMfz
        OHpO73JrhQzd3tDw==
From:   "tip-bot2 for Rasmus Villemoes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: cper: fix scnprintf() use in cper_mem_err_location()
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163014706409.25758.9928933953235257712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     5eff88dd6b4badd664d7d3b648103d540b390248
Gitweb:        https://git.kernel.org/tip/5eff88dd6b4badd664d7d3b648103d540b390248
Author:        Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate:    Wed, 21 Apr 2021 21:31:46 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 27 Aug 2021 16:01:27 +02:00

efi: cper: fix scnprintf() use in cper_mem_err_location()

The last two if-clauses fail to update n, so whatever they might have
written at &msg[n] would be cut off by the final nul-termination.

That nul-termination is redundant; scnprintf(), just like snprintf(),
guarantees a nul-terminated output buffer, provided the buffer size is
positive.

And there's no need to discount one byte from the initial buffer;
vsnprintf() expects to be given the full buffer size - it's not going
to write the nul-terminator one beyond the given (buffer, size) pair.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/cper.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index ea7ca74..1cb7097 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -221,7 +221,7 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		return 0;
 
 	n = 0;
-	len = CPER_REC_LEN - 1;
+	len = CPER_REC_LEN;
 	if (mem->validation_bits & CPER_MEM_VALID_NODE)
 		n += scnprintf(msg + n, len - n, "node: %d ", mem->node);
 	if (mem->validation_bits & CPER_MEM_VALID_CARD)
@@ -258,13 +258,12 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "responder_id: 0x%016llx ",
 			       mem->responder_id);
 	if (mem->validation_bits & CPER_MEM_VALID_TARGET_ID)
-		scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
-			  mem->target_id);
+		n += scnprintf(msg + n, len - n, "target_id: 0x%016llx ",
+			       mem->target_id);
 	if (mem->validation_bits & CPER_MEM_VALID_CHIP_ID)
-		scnprintf(msg + n, len - n, "chip_id: %d ",
-			  mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
+		n += scnprintf(msg + n, len - n, "chip_id: %d ",
+			       mem->extended >> CPER_MEM_CHIP_ID_SHIFT);
 
-	msg[n] = '\0';
 	return n;
 }
 
