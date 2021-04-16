Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA0362678
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbhDPROS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 13:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhDPROR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 13:14:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86201C061756;
        Fri, 16 Apr 2021 10:13:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 17:13:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618593224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMNyHYS1vpG2WgX7rE/nYyKQRQmJDT7+w90eGYZShPQ=;
        b=z9FWfSKpW+w+xIYEUQOJHckYcnRftvzF0SyHEK6msPjwm0AOyndq7+0IazlXKM+j09lDi0
        jQnA1HTUUD4C0G1l5cML9oYMxL8mUtUnrf7Ao09U6peTUbck+rNsjySCe6S58L+Cg3UD3V
        YhJ2fOHOuLOAS5rLLVna7gSst2uztfdKUBAq90/JdRjvlG2X7iSzBWln5ZieF7xjfeQRsS
        Vmbg0sx61MnRIvMJui4AxmPxIGnmidR8BE5IChAnojbum53zgu0HehwUeuz4/7I+GEp3Nu
        LQTFgBmGtXtzeSh+3eV8R6LjEir1D5vHUlaGc+Fad1ptlfJeDfLSh87uaglmvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618593224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMNyHYS1vpG2WgX7rE/nYyKQRQmJDT7+w90eGYZShPQ=;
        b=nW8XYwwq2Pwv5ELl/yhqfXl6CftEGPoBcX5ZvI9EVq3GBSJxQ/Pr/JLKEqQNBk4N4f+ilj
        3EEB83SuGSw5XYCg==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/events/amd/iommu: Fix sysfs type mismatch
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210415001112.3024673-1-nathan@kernel.org>
References: <20210415001112.3024673-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <161859322338.29796.3589320816461974467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     de5bc7b425d4c27ae5faa00ea7eb6b9780b9a355
Gitweb:        https://git.kernel.org/tip/de5bc7b425d4c27ae5faa00ea7eb6b9780b9a355
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 14 Apr 2021 17:11:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 18:58:52 +02:00

x86/events/amd/iommu: Fix sysfs type mismatch

dev_attr_show() calls _iommu_event_show() via an indirect call but
_iommu_event_show()'s type does not currently match the type of the
show() member in 'struct device_attribute', resulting in a Control Flow
Integrity violation.

$ cat /sys/devices/amd_iommu_1/events/mem_dte_hit
csource=0x0a

$ dmesg | grep "CFI failure"
[ 3526.735140] CFI failure (target: _iommu_event_show...):

Change _iommu_event_show() and 'struct amd_iommu_event_desc' to
'struct device_attribute' so that there is no more CFI violation.

Fixes: 7be6296fdd75 ("perf/x86/amd: AMD IOMMU Performance Counter PERF uncore PMU implementation")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210415001112.3024673-1-nathan@kernel.org
---
 arch/x86/events/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index be50ef8..6a98a76 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -81,12 +81,12 @@ static struct attribute_group amd_iommu_events_group = {
 };
 
 struct amd_iommu_event_desc {
-	struct kobj_attribute attr;
+	struct device_attribute attr;
 	const char *event;
 };
 
-static ssize_t _iommu_event_show(struct kobject *kobj,
-				struct kobj_attribute *attr, char *buf)
+static ssize_t _iommu_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	struct amd_iommu_event_desc *event =
 		container_of(attr, struct amd_iommu_event_desc, attr);
