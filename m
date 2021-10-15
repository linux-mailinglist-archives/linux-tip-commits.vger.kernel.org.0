Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20C42EDB6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbhJOJeJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbhJOJeI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:34:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17D2C061570;
        Fri, 15 Oct 2021 02:32:02 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:32:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634290321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yNzDI54fl6ud2EMFiDssRzgtgjvP+mS8/MeeBUvYlc=;
        b=g1VzRJ6fIwcyUcQCgrl2Htp5T5/cDWG8EcWiSgOdQZQirC0Re6twSe1BaQPwuXN4WOat4k
        InicP00aCXnK1v+fOkhNBWIpajcyOR9uVjG8NNG/o8dj7kWz93dN4EEsRfgNncSbguDC4L
        GDh3NuKPEMKXIIcbNh/ql/UtnBswIYxFOZc4KY8GXHwjckFFWPrsCTytxVo1WPQfm8/C+D
        Y2n14TajJ6kUBODnnWJRBe3yevjqLslUXI6XulTBVZToycmRoHzq1SvxLBwW0kXZhtFhGG
        gy30WwE7z3RO48qA8m1aUGKj9qowadIQDxV7B5KZRiMi4gFAuZrI4nYsZt/Fiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634290321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yNzDI54fl6ud2EMFiDssRzgtgjvP+mS8/MeeBUvYlc=;
        b=pWlv4nT4omscYM/wmwv3DdkkKRSpudOZwgsYe2I6ihuU9VaRMS9IB98HuSt3728N9cs9mY
        f0IsLzvKCW+B3DCg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/msr: Add Sapphire Rapids CPU support
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1633551137-192083-1-git-send-email-kan.liang@linux.intel.com>
References: <1633551137-192083-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163429032051.25758.2605197618414983019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     71920ea97d6d1d800ee8b51951dc3fda3f5dc698
Gitweb:        https://git.kernel.org/tip/71920ea97d6d1d800ee8b51951dc3fda3f5dc698
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 06 Oct 2021 13:12:17 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:26 +02:00

perf/x86/msr: Add Sapphire Rapids CPU support

SMI_COUNT MSR is supported on Sapphire Rapids CPU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1633551137-192083-1-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index c853b28..96c775a 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -68,6 +68,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_BROADWELL_D:
 	case INTEL_FAM6_BROADWELL_G:
 	case INTEL_FAM6_BROADWELL_X:
+	case INTEL_FAM6_SAPPHIRERAPIDS_X:
 
 	case INTEL_FAM6_ATOM_SILVERMONT:
 	case INTEL_FAM6_ATOM_SILVERMONT_D:
