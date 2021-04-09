Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3CE359C08
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbhDIK1y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhDIK1o (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BE9C0613D7;
        Fri,  9 Apr 2021 03:27:31 -0700 (PDT)
Date:   Fri, 09 Apr 2021 10:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ufsqc3IAeOJkI8X3YsN9NMhPF6J1+bA7CsxiiApOGe0=;
        b=Qapb/JPIL0g0EExMeSxT6rfOjK+IoneRZ2EAeTGLUJdoU+jBryKdRWCjgafzVi45AocAsW
        pTzrgwibSbtYBNmSEcEOQk/BMwdSIRbMtHpDFWmt7pLpgPeKQV4+sXD8vEZ7Zq+EF13Au2
        o4UCGFaIOpLWqunSFNR+jLemcP42Df2b3iNaZDMwKbrBQBWltLw8snVDcYTVirV0RWCBx9
        R15D0myKxSFMyO91PaibZQ0n2Ovxl2UOcwdd5vMo2h/EXQ//Q39vPKz5PqWQSSX2O/g++M
        kl9hrwz6z9UVxF8Su5cAEq//MYnIk/90hgHrAFcDc/PqhWOUaTFW8ysvtM003Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ufsqc3IAeOJkI8X3YsN9NMhPF6J1+bA7CsxiiApOGe0=;
        b=sjpBoMvL9O4tVcOlhY0JWKZGtTkbTELvItlI9yc81owyeAwtQ8oSTjqM3ln1fyLdWLvFmL
        t497Gs1hL4vD/0Cg==
From:   "tip-bot2 for Paul Cercueil" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic-ost: Add support for
 the JZ4760B
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210308212302.10288-3-paul@crapouillou.net>
References: <20210308212302.10288-3-paul@crapouillou.net>
MIME-Version: 1.0
Message-ID: <161796404942.29796.10101610157646631598.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     352408aff91d06fd2f0e35d52079bd0cd70cd29e
Gitweb:        https://git.kernel.org/tip/352408aff91d06fd2f0e35d52079bd0cd70cd29e
Author:        Paul Cercueil <paul@crapouillou.net>
AuthorDate:    Mon, 08 Mar 2021 21:23:02 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:23:23 +02:00

clocksource/drivers/ingenic-ost: Add support for the JZ4760B

The OST in the JZ4760B SoC works exactly the same as in the JZ4770. But
since the JZ4760B is older, its Device Tree string does not fall back to
the JZ4770 one; so add support for the JZ4760B compatible string here.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210308212302.10288-3-paul@crapouillou.net
---
 drivers/clocksource/ingenic-ost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index 029efc2..d2d6646 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -167,13 +167,14 @@ static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
 	.is64bit = false,
 };
 
-static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
+static const struct ingenic_ost_soc_info jz4760b_ost_soc_info = {
 	.is64bit = true,
 };
 
 static const struct of_device_id ingenic_ost_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
-	{ .compatible = "ingenic,jz4770-ost", .data = &jz4770_ost_soc_info, },
+	{ .compatible = "ingenic,jz4760b-ost", .data = &jz4760b_ost_soc_info, },
+	{ .compatible = "ingenic,jz4770-ost", .data = &jz4760b_ost_soc_info, },
 	{ }
 };
 
