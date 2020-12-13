Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEDE2D9026
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgLMTB6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgLMTBn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B088C061794;
        Sun, 13 Dec 2020 11:01:03 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2CWmt+MYbczn5POC0ab9eaYrAEP81YbLg/+nK8yKI+A=;
        b=ZcScYWBNuQE0UEVelZnBSPkyIuY634egMo3FUOfQSiLlEVQaBWKDiYVPhxUlvHv1IUDKAh
        A+40xLrdxynZNGk1aioGkFkEQrKlgj4mXffUG7gqQNWeWo4hJDzwELuupGL8C1GNmsVRa9
        fBxlwq0RYnqbgewhk0dH2SWquy3WhYbdv7RwzNQiyyrTGeNnQRzfnKlgIUM7X5ap5IRdVQ
        9wyZRwqRI6UhMLterZn2OIbYEQYL7l5Uc16+uVolMbmRn52y/sTCOkB0fjMEsC9ZMH3Kp1
        q/5gQmW0LSOSF6tKW3eJjKkr2HWiLOxJsSsgncDbOvB1w43fiUJ/T+14Wg2VRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2CWmt+MYbczn5POC0ab9eaYrAEP81YbLg/+nK8yKI+A=;
        b=pLb6tJTdnoZiRhb9sTr0aEs4Bshp0l/7NKTyVjohtCapirLnVsliT9fRpSQJ0HQmOTIcU9
        Dejd4wfe99ogimDA==
From:   "tip-bot2 for Joe Perches" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Make struct kernel_param_ops definitions const
Cc:     Joe Perches <joe@perches.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606130.3364.817044402973397891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7c47ee5aa00817d8b10f415b4a92d5fb3ac35273
Gitweb:        https://git.kernel.org/tip/7c47ee5aa00817d8b10f415b4a92d5fb3ac35273
Author:        Joe Perches <joe@perches.com>
AuthorDate:    Sat, 03 Oct 2020 17:18:08 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 19 Nov 2020 19:37:17 -08:00

rcu/tree: Make struct kernel_param_ops definitions const

These should be const, so make it so.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e4d6d0b..5f458e4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -546,12 +546,12 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	return ret;
 }
 
-static struct kernel_param_ops first_fqs_jiffies_ops = {
+static const struct kernel_param_ops first_fqs_jiffies_ops = {
 	.set = param_set_first_fqs_jiffies,
 	.get = param_get_ulong,
 };
 
-static struct kernel_param_ops next_fqs_jiffies_ops = {
+static const struct kernel_param_ops next_fqs_jiffies_ops = {
 	.set = param_set_next_fqs_jiffies,
 	.get = param_get_ulong,
 };
