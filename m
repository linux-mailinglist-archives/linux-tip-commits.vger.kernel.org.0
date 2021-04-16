Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAC36234C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245144AbhDPPCP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbhDPPCO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C6BC061574;
        Fri, 16 Apr 2021 08:01:49 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYZWPtDMrEcYhCUgO6OL6PA5yeacxbkEGBOxZmZxr2o=;
        b=UjdnVojhsS8+Vo27cJ+tevrqLVVM0+jZ91rZy0/BWezxhkxMJqAl0Xx2NwkyO/WvcVI9PP
        t3KaWZEv8nKGWXy6fyENTTfnytMOxXXNc4bGyu9RxuZIiYn9awOU0gHrzQHwHD8PFfvBG2
        aPnKNwixdObByDKD3G6AowUIGsXhqfUif4lKXq4pyx8ILueMMOYiAZXWurIL+8EFUzjXpG
        8j4tulLSDsW7SGknIV1ZVdassg09SwNMmdrzVezra/HgW2ugOo0H93EPFRjek96X9AmIXD
        dMKjvsIK+N+fFwMvi95EBiu1XlejzbFbYVHxHzoSRhBCz8B7aOQ0wYSZfnzD3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585307;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYZWPtDMrEcYhCUgO6OL6PA5yeacxbkEGBOxZmZxr2o=;
        b=MBZhr2neHzVt0lPC7Nupp0wne9NmdnjvnHWgJVWJlxFMsE/QvdD/BSOXypILnxTLMdCXX0
        Id7aHVWMXYeeocAA==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Fix sysfs type mismatch
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210415001112.3024673-2-nathan@kernel.org>
References: <20210415001112.3024673-2-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <161858530676.29796.11038219693282032016.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b04c0cddff6d1d6656c7f7c08c0b8f07eb287564
Gitweb:        https://git.kernel.org/tip/b04c0cddff6d1d6656c7f7c08c0b8f07eb287564
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 14 Apr 2021 17:11:12 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:44 +02:00

perf/amd/uncore: Fix sysfs type mismatch

dev_attr_show() calls the __uncore_*_show() functions via an indirect
call but their type does not currently match the type of the show()
member in 'struct device_attribute', resulting in a Control Flow
Integrity violation.

$ cat /sys/devices/amd_l3/format/umask
config:8-15

$ dmesg | grep "CFI failure"
[ 1258.174653] CFI failure (target: __uncore_umask_show...):

Update the type in the DEFINE_UNCORE_FORMAT_ATTR macro to match
'struct device_attribute' so that there is no more CFI violation.

Fixes: 06f2c24584f3 ("perf/amd/uncore: Prepare to scale for more attributes that vary per family")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210415001112.3024673-2-nathan@kernel.org
---
 arch/x86/events/amd/uncore.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 7f014d4..582c0ff 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -275,14 +275,14 @@ static struct attribute_group amd_uncore_attr_group = {
 };
 
 #define DEFINE_UNCORE_FORMAT_ATTR(_var, _name, _format)			\
-static ssize_t __uncore_##_var##_show(struct kobject *kobj,		\
-				struct kobj_attribute *attr,		\
+static ssize_t __uncore_##_var##_show(struct device *dev,		\
+				struct device_attribute *attr,		\
 				char *page)				\
 {									\
 	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
 	return sprintf(page, _format "\n");				\
 }									\
-static struct kobj_attribute format_attr_##_var =			\
+static struct device_attribute format_attr_##_var =			\
 	__ATTR(_name, 0444, __uncore_##_var##_show, NULL)
 
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
