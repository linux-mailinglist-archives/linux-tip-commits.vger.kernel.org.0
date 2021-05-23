Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9625038DAC0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 May 2021 11:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhEWJse (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 23 May 2021 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbhEWJsa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 23 May 2021 05:48:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C5C061574;
        Sun, 23 May 2021 02:47:04 -0700 (PDT)
Date:   Sun, 23 May 2021 09:46:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621763220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+dc9g6TaTC8U1WddrtiG0MD5xMD1aM3fwqtAmpRJOfo=;
        b=ZNaMiI7v3hCHnxdph8Sr41lz9VL2J8Xbt2uHGaDIImQqQBQo0lvSh4qAOnR/s9PeVcUrPz
        WLR/mln55xGm3h+ffG/F3GBCd21HTRUv/DrA+XqjAOeq5rulv7+KRDmZ6ATUrhociS0Lj1
        Da/MWby2PAJV1L26twVPH7yU9m7Pvk4vaABblYzxqrSSYNnY8LxR5Sk2vKosPhXPyvPTGP
        qN4tsPbqLnnIR0ZuDJNAZSZZ8htvUkT0kxkwNx2R7rMJ+JnIhZb3OBXx+VXuOMMxdzYweo
        cjSTFRkJkpugdAz0iIiiKuUxv73YXBHi8t0mTAYDxwptFKsETQH79vy1LyY40A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621763220;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+dc9g6TaTC8U1WddrtiG0MD5xMD1aM3fwqtAmpRJOfo=;
        b=nYIliH5VAXw10xL2fC/wcQoYXx0pqoblZ2Euz1j40SqPTcWS+JaM8GwSHvxg16Dc8fgbwc
        Ey8YjvJxho3uB5Cw==
From:   "tip-bot2 for Rasmus Villemoes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: cper: fix snprintf() use in cper_dimm_err_location()
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162176321915.29796.5574808163989432788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     942859d969de7f6f7f2659a79237a758b42782da
Gitweb:        https://git.kernel.org/tip/942859d969de7f6f7f2659a79237a758b42782da
Author:        Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate:    Wed, 21 Apr 2021 21:46:36 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Sat, 22 May 2021 14:05:37 +02:00

efi: cper: fix snprintf() use in cper_dimm_err_location()

snprintf() should be given the full buffer size, not one less. And it
guarantees nul-termination, so doing it manually afterwards is
pointless.

It's even potentially harmful (though probably not in practice because
CPER_REC_LEN is 256), due to the "return how much would have been
written had the buffer been big enough" semantics. I.e., if the bank
and/or device strings are long enough that the "DIMM location ..."
output gets truncated, writing to msg[n] is a buffer overflow.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Fixes: 3760cd20402d4 ("CPER: Adjust code flow of some functions")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/cper.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index e15d484..ea7ca74 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -276,8 +276,7 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 	if (!msg || !(mem->validation_bits & CPER_MEM_VALID_MODULE_HANDLE))
 		return 0;
 
-	n = 0;
-	len = CPER_REC_LEN - 1;
+	len = CPER_REC_LEN;
 	dmi_memdev_name(mem->mem_dev_handle, &bank, &device);
 	if (bank && device)
 		n = snprintf(msg, len, "DIMM location: %s %s ", bank, device);
@@ -286,7 +285,6 @@ static int cper_dimm_err_location(struct cper_mem_err_compact *mem, char *msg)
 			     "DIMM location: not present. DMI handle: 0x%.4x ",
 			     mem->mem_dev_handle);
 
-	msg[n] = '\0';
 	return n;
 }
 
