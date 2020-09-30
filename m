Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C2827F21C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 21:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgI3S65 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 14:58:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730436AbgI3S64 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:56 -0400
Date:   Wed, 30 Sep 2020 18:58:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601492334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdnwzdonN6u4LB8CVus79ZJeeIfXYlzK3NjD4Y09slk=;
        b=xHPJUPfhOALyHDRWsMMFGBmx4zXIYjG7nY+nNUZ5W/JNVHr5NuUsidDtQfQ3N4EmnRFIf2
        RQsmVnZc8to/yQqUFLJi56DNplaIpx8xpqu1brrDrnxQM1v5Qq6auaVJACYuDPXvyQOLc9
        DM0fROsiMAtWoaZfCVmagbRKrOolxqBr7HacpyYh/hE9W6Y4xMIGx6LkT1ChygiTWNjsp/
        dCZrEm/MvLt2XtX8pP2I3npRM1gmrojHg+TrprWNDuS6k3Q6vv2xqQA4cubhqaTlZf10tx
        cEcEpdHFGEwxIixzPhSWQBHrHhfwcxnVwA6yNBk2QB/Gq6RN5TBb7LHbcqCitg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601492334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdnwzdonN6u4LB8CVus79ZJeeIfXYlzK3NjD4Y09slk=;
        b=rKqTso6Y6bHomOf2G5ad44bQZLG/959Z9FNAqCT8IMjo7IfIBqQe2zXHiAPfs//pOmalp6
        teOKwtJDLtwbEICw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add Jasper Lake support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1601296242-32763-2-git-send-email-kan.liang@linux.intel.com>
References: <1601296242-32763-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160149233376.7002.4167522878778127644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c3bb8a9fa31b99f5b7d2e45cd0a10db91349f4c9
Gitweb:        https://git.kernel.org/tip/c3bb8a9fa31b99f5b7d2e45cd0a10db91349f4c9
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 28 Sep 2020 05:30:42 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 29 Sep 2020 09:57:02 +02:00

perf/x86/msr: Add Jasper Lake support

The Jasper Lake processor is also a Tremont microarchitecture. From the
perspective of perf MSR, there is nothing changed compared with
Elkhart Lake.
Share the code path with Elkhart Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1601296242-32763-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index a949f6f..4be8f9c 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -78,6 +78,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 	case INTEL_FAM6_ATOM_TREMONT_D:
 	case INTEL_FAM6_ATOM_TREMONT:
+	case INTEL_FAM6_ATOM_TREMONT_L:
 
 	case INTEL_FAM6_XEON_PHI_KNL:
 	case INTEL_FAM6_XEON_PHI_KNM:
