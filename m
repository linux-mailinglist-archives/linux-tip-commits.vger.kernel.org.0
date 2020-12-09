Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726D92D496B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgLISpV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbgLISpV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:45:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B981C061793;
        Wed,  9 Dec 2020 10:44:41 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:44:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dWDhCpRyIuLg71OdNwrazDrwXj7XrTRu/wCgKmT6+OA=;
        b=NhTirKPXinCvMcPNgVBDnczrTMyyY/IzCiHJZL7pN0pnxkK3exk53ip2Zh6MNubBPoG3BZ
        O093Fyq+v63VXSmzqpx3Dv8j7kdn8r2hJRHSbzjCXIPvW5k99HDBh61vuKjCTbNMoG0oQk
        QL+/txKtz8dvegFkNwvnMhC2lHmH2XvswvrlZggTsEhXtYm7HTMCs4dcPXemB7WOR9ge9W
        s55WwjSRKoR4crkDtJHPkZA68RFEUwW918xZnB0A2gp0lMJ705hlHkMT82PE4HVawAd2wH
        mvAgpMrQgfiuZpdDAQI5tJxLfA2AZoWZJi2kdu59jvAbtOywKHBUW1NRfOhAHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dWDhCpRyIuLg71OdNwrazDrwXj7XrTRu/wCgKmT6+OA=;
        b=+0jW0U/ZhyJ9Kb8kg/1dh7Nl+4Ug8/tKsdErlfBw/HWEf7uOymyxMhb9eKRtf0xKoKfQnR
        4MG377kZ4/LhP1Aw==
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes/x86: Fix fall-through warnings for Clang
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160753947905.3364.18345219723110466627.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bd11952b400fdfdf3b017500ad6475f5b624d167
Gitweb:        https://git.kernel.org/tip/bd11952b400fdfdf3b017500ad6475f5b624d167
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Fri, 20 Nov 2020 12:32:37 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:59 +01:00

uprobes/x86: Fix fall-through warnings for Clang

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/KSPP/linux/issues/115
---
 arch/x86/kernel/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3fdaa04..90f44f4 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1015,6 +1015,8 @@ int arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val,
 		if (uprobe_post_sstep_notifier(regs))
 			ret = NOTIFY_STOP;
 
+		break;
+
 	default:
 		break;
 	}
