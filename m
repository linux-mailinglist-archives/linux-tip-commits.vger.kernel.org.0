Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809C2368DAD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Apr 2021 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbhDWHLE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Apr 2021 03:11:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44092 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240809AbhDWHLD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Apr 2021 03:11:03 -0400
Date:   Fri, 23 Apr 2021 07:10:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619161826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09dBzRNeTTyOEBMb99GRp77QLkcjKqVQA+vtksddIKw=;
        b=Gj4i5rAVtpOVfPgVW9+n+adJ1hcOLJypWgmiQu9uQA1ToZAA6QUEzQEeXakp5uboHyNX1x
        6D5Q2ltgb6FovWTDOhaG7zncAYzYnldnoCu+DqAAo1ZIQ7LTbHcaUEAMQp0fGVW022gupw
        c3Z67Pl7L5p1AZR3/di1J0mKX+WSgV/cZfMnImeysm58oit4lKkEfau2sZtqj/yyX0EsqT
        xXIYLeS2AVUAeHFnkDI68CLv39yw0aVsZxVBrSg3zNCkpjleUtpg+S41j38rMpCo3RU+Ah
        5wbpMQjHtzMk1B1DfwbEpAHKQe4Mf5pC1OC3G/a4uOO6T8WMMmcpmTSQDczeuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619161826;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09dBzRNeTTyOEBMb99GRp77QLkcjKqVQA+vtksddIKw=;
        b=7ILJaY3pDa7d/5l9yUvfvAUlWQQpC9+5hV0oVzlmy/GLIChJ6gRCEKJp9A8BEx2nQvylgS
        q1apND61DSc6AUCg==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Allow for 8<num_fixed_counters<16
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210420142907.382417-1-colin.king@canonical.com>
References: <20210420142907.382417-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <161916182610.29796.18400441270045420747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     32d35c4a96ec79446f0d7be308a6eb248b507a0b
Gitweb:        https://git.kernel.org/tip/32d35c4a96ec79446f0d7be308a6eb248b507a0b
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Tue, 20 Apr 2021 15:29:07 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 23 Apr 2021 09:03:15 +02:00

perf/x86: Allow for 8<num_fixed_counters<16

The 64 bit value read from MSR_ARCH_PERFMON_FIXED_CTR_CTRL is being
bit-wise masked with the value (0x03 << i*4). However, the shifted value
is evaluated using 32 bit arithmetic, so will UB when i > 8. Fix this
by making 0x03 a ULL so that the shift is performed using 64 bit
arithmetic.

This makes the arithmetic internally consistent and preparers for the
day when hardware provides 8<num_fixed_counters<16.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210420142907.382417-1-colin.king@canonical.com
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3fe66b7..c7fcc8d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -278,7 +278,7 @@ bool check_hw_exists(struct pmu *pmu, int num_counters, int num_counters_fixed)
 		for (i = 0; i < num_counters_fixed; i++) {
 			if (fixed_counter_disabled(i, pmu))
 				continue;
-			if (val & (0x03 << i*4)) {
+			if (val & (0x03ULL << i*4)) {
 				bios_fail = 1;
 				val_fail = val;
 				reg_fail = reg;
