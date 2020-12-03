Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71992CE301
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Dec 2020 00:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgLCXtN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgLCXtN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 3 Dec 2020 18:49:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92877C08E85E;
        Thu,  3 Dec 2020 15:47:55 -0800 (PST)
Date:   Thu, 03 Dec 2020 23:47:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607039274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4k7W5jWsWcEX3tFAgDn6KJ7NxWCRbFRcKDWm57n5Go=;
        b=i7NkDtqWm270qyTD6+p8T9PqGtVmeaDPf3dJm1nns62E5aC2u8GujWLTbgmFhQDA2cvyWP
        fv5H+ruUJVdsmnW8O2xrAT6igAlYaUSj/fKSFYdB0FUq8wc9aSxkDF1+l/v9WcZ5SH2OSp
        0F5Vqmxw4coO3qe/OJkQdMOF6tNwZNuxLBfY5NEJFVwmO0e7itEKIPf2GE1KrrDx5v6M3p
        +wjoVuPjzBHKGdUYJRXNPYenMQXpqQpYKaNb0ziV2q9jG0m38jzxw9jagaCBma/R7srBV8
        VS5qQoGjpdweBqC9cDI5LVeCMsJ5YSb8RGuJ+jqfSJ5GkccL0PMecnrTlp8NSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607039274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4k7W5jWsWcEX3tFAgDn6KJ7NxWCRbFRcKDWm57n5Go=;
        b=GstNyRVkQZWCLKZwajKnlz9YIg0JTQOs0vFovIt1f5Igno4pcn+nkCiPT8VOvqjUkqd/4w
        VhjWs4MRjYKshrDg==
From:   "tip-bot2 for Kefeng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/sp804: Make some symbol static
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201029123317.90286-2-wangkefeng.wang@huawei.com>
References: <20201029123317.90286-2-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Message-ID: <160703927345.3364.10711174993693216842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3c07bf0fc3558f680374f8ac6d148b0082aa08c6
Gitweb:        https://git.kernel.org/tip/3c07bf0fc3558f680374f8ac6d148b0082aa08c6
Author:        Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate:    Thu, 29 Oct 2020 20:33:14 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 03 Dec 2020 19:16:17 +01:00

clocksource/drivers/sp804: Make some symbol static

drivers/clocksource/timer-sp804.c:38:31: warning: symbol 'arm_sp804_timer' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:47:31: warning: symbol 'hisi_sp804_timer' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:120:12: warning: symbol 'sp804_clocksource_and_sched_clock_init' was not declared. Should it be static?
drivers/clocksource/timer-sp804.c:219:12: warning: symbol 'sp804_clockevents_init' was not declared. Should it be static?

And move __initdata after the variables.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201029123317.90286-2-wangkefeng.wang@huawei.com
---
 drivers/clocksource/timer-sp804.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index db5330c..22a68cb 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -34,8 +34,7 @@
 #define HISI_TIMER_BGLOAD	0x20
 #define HISI_TIMER_BGLOAD_H	0x24
 
-
-struct sp804_timer __initdata arm_sp804_timer = {
+static struct sp804_timer arm_sp804_timer __initdata = {
 	.load		= TIMER_LOAD,
 	.value		= TIMER_VALUE,
 	.ctrl		= TIMER_CTRL,
@@ -44,7 +43,7 @@ struct sp804_timer __initdata arm_sp804_timer = {
 	.width		= 32,
 };
 
-struct sp804_timer __initdata hisi_sp804_timer = {
+static struct sp804_timer hisi_sp804_timer __initdata = {
 	.load		= HISI_TIMER_LOAD,
 	.load_h		= HISI_TIMER_LOAD_H,
 	.value		= HISI_TIMER_VALUE,
