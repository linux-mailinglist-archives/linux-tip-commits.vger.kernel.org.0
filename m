Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5C39BA3F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jun 2021 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhFDNwf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Jun 2021 09:52:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53556 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbhFDNwb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Jun 2021 09:52:31 -0400
Date:   Fri, 04 Jun 2021 13:50:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622814644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PaP2rIdOEekIJ9b/kNZAsaRsupNN0g6L7nIiW85A5U=;
        b=yYXb9VrIUwkcVHm9a+V8Cz+4hKESBHOkp/Vx3wugQooV8wyAWV5en0NIUZnqVmRFfzMi5O
        6zTmYikr90ljR5ZNRUn4fLwuZvJawVYSRu4W4um9iyIcEiVlrT/n8fAQIv9hxXAdx6xk+7
        VMU9A7tCLoI+0GCp109eESiSlXPl9MFBbOOOjsdm1ECdCJwyR9xV333jdQm+uVCSPLtjf8
        GtYHw5K/EI4x9Rx9LnhDOtY6dvK2bte7Udywh3HhYslSHp2Yx983SNYa0d3IzwjYz5t3kx
        8mXl1RqrWMqxi1T9Xd7MImeGtKk3KGIF3o86K/rx+y2QpoA4EjlvzqonFz0PRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622814644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8PaP2rIdOEekIJ9b/kNZAsaRsupNN0g6L7nIiW85A5U=;
        b=LO+fO/RVkcLidWQGgFcmLrS7EX6qUcoHr2iHA6LjUqdQlTHE1RZInPYO11xZupY0aBQh+T
        UDzmOogA8iExTkDw==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/mce_amd: Fix typo "FIfo" -> "Fifo"
Cc:     Colin Ian King <colin.king@canonical.com>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210603103349.79117-1-colin.king@canonical.com>
References: <20210603103349.79117-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <162281464318.29796.6032991160827413746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     429b2ba70812fc8ce7c591e787ec0f2b48d13319
Gitweb:        https://git.kernel.org/tip/429b2ba70812fc8ce7c591e787ec0f2b48d13319
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 03 Jun 2021 11:33:49 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 04 Jun 2021 15:44:25 +02:00

EDAC/mce_amd: Fix typo "FIfo" -> "Fifo"

There is an uppercase letter I in one of the MCE error descriptions
instead of a lowercase one. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20210603103349.79117-1-colin.king@canonical.com
---
 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 43ba0f9..27d5692 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -431,7 +431,7 @@ static const char * const smca_xgmipcs_mce_desc[] = {
 	"Replay Buffer Parity Error",
 	"Data Parity Error",
 	"Replay Fifo Overflow Error",
-	"Replay FIfo Underflow Error",
+	"Replay Fifo Underflow Error",
 	"Elastic Fifo Overflow Error",
 	"Deskew Error",
 	"Flow Control CRC Error",
