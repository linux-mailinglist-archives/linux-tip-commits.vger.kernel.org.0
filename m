Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FB396340
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhEaPKy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 11:10:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbhEaPIn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 11:08:43 -0400
Date:   Mon, 31 May 2021 15:07:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622473621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDgDb1KuYu9v1NywTpt+9WrEzXc2X69AKBlzVWSDTGQ=;
        b=Qi+yOOPRFsP0QJLlIU3/hHzqJt0b0wzKRUGMrBGqvxPag80PB8GfqXMhXZ9cH7PacaZqns
        7J5vUOXKNaRkjeF+kLsHSASOuKLZO2KjCmMYdyQ+9z3TVtXtQ+/giXzbd8Q4FKePQ1iDOh
        S5+gwuHQXjeyqSvnUma0i4HcDFZFP4f7RqbaoysPP5YZPYD1Z5j6d7AitDcngE5cNZSlnL
        C9UxUOvaGjRIGGTaezoCJTYbCFcW57+j30uVhQ9IPFDMGrwh8MNrryicUB8Cyo4yDD6UxH
        jnWMGyELiHsl57ILT0q5FRoJvVRS6VRFWI+wKEvcIjGucYduGGvHT2WAHGDW/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622473621;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDgDb1KuYu9v1NywTpt+9WrEzXc2X69AKBlzVWSDTGQ=;
        b=2iWQYdFtURIifV4EzggLlAdR7mVI6lJIDJLiOyfhv7+X3E3R9dUoIvrHPupPDwzRPlNLnk
        q3DMfDKtalf8JhBw==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Use DEVICE_ATTR_[RO|WO] macros
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210523065825.19684-1-yuehaibing@huawei.com>
References: <20210523065825.19684-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <162247362065.29796.15883057337417984769.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1fa98d96ea0ff6c8770eeba90417aab4b4e07f52
Gitweb:        https://git.kernel.org/tip/1fa98d96ea0ff6c8770eeba90417aab4b4e07f52
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Sun, 23 May 2021 14:58:25 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 31 May 2021 17:04:42 +02:00

clockevents: Use DEVICE_ATTR_[RO|WO] macros

Use the DEVICE_ATTR_[RO|WO] helpers instead of plain DEVICE_ATTR, which
makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210523065825.19684-1-yuehaibing@huawei.com

---
 kernel/time/clockevents.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index f549022..0056d2b 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -668,9 +668,9 @@ static struct bus_type clockevents_subsys = {
 static DEFINE_PER_CPU(struct device, tick_percpu_dev);
 static struct tick_device *tick_get_tick_dev(struct device *dev);
 
-static ssize_t sysfs_show_current_tick_dev(struct device *dev,
-					   struct device_attribute *attr,
-					   char *buf)
+static ssize_t current_device_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
 {
 	struct tick_device *td;
 	ssize_t count = 0;
@@ -682,12 +682,12 @@ static ssize_t sysfs_show_current_tick_dev(struct device *dev,
 	raw_spin_unlock_irq(&clockevents_lock);
 	return count;
 }
-static DEVICE_ATTR(current_device, 0444, sysfs_show_current_tick_dev, NULL);
+static DEVICE_ATTR_RO(current_device);
 
 /* We don't support the abomination of removable broadcast devices */
-static ssize_t sysfs_unbind_tick_dev(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
+static ssize_t unbind_device_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
 {
 	char name[CS_NAME_LEN];
 	ssize_t ret = sysfs_get_uname(buf, name, count);
@@ -714,7 +714,7 @@ static ssize_t sysfs_unbind_tick_dev(struct device *dev,
 	mutex_unlock(&clockevents_mutex);
 	return ret ? ret : count;
 }
-static DEVICE_ATTR(unbind_device, 0200, NULL, sysfs_unbind_tick_dev);
+static DEVICE_ATTR_WO(unbind_device);
 
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static struct device tick_bc_dev = {
