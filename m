Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822D232C791
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358993AbhCDAcR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842934AbhCCKWm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BDBC08EC29;
        Wed,  3 Mar 2021 01:49:38 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlyLcs93rZ8ecJWon5r+ERENd4253orZt7gs0sUfCXE=;
        b=bwvXW7RGJvyxraJtKNcRCvVzcJC08MhTm+nCb3Bcx4Bke6EagBDAXK+jzsEsbAPPKJErut
        rFIr59WnUz+I65As529HSOn9AkQWd+MWSBVYVGM5J+PQ/Ki+z1V2Wyv6YLVLkm/XBWg0T6
        GbKm2C0lHmVmtT1vrNt1HSxDZ50tWeRVCuP5hndT/u8H1OpDRhGtYnIF/P5zmQV+BWhKXN
        +ulckQrijaKybA1mJ94U+SCItKMlvU3L3/gDZ3nAnFTRbhmH9jouRXlPyYVBZYP61xBwKd
        M+Wf7BhgtsPj1PeevE2xP1KjF4o0bLHi7pK3iq4FCjv3Ic42XODVeEkFmJpX4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764975;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PlyLcs93rZ8ecJWon5r+ERENd4253orZt7gs0sUfCXE=;
        b=woEofQqx/Qz2toJswJLd34E4X3OuYOHjk8QM54PlbqNNdCsERkEgsTsZwTHPsTQA7+1sPz
        Ro3q3T33mVACgqBg==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpu/hotplug: Allowing to reset fail injection
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210216103506.416286-2-vincent.donnefort@arm.com>
References: <20210216103506.416286-2-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <161476497509.20312.11412561789577463928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6d06c515e9151dc858e391bd6bebce0b684eec4f
Gitweb:        https://git.kernel.org/tip/6d06c515e9151dc858e391bd6bebce0b684eec4f
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Tue, 16 Feb 2021 10:35:04 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:33:00 +01:00

cpu/hotplug: Allowing to reset fail injection

Currently, the only way of resetting the fail injection is to trigger a
hotplug, hotunplug or both. This is rather annoying for testing
and, as the default value for this file is -1, it seems pretty natural to
let a user write it.

Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210216103506.416286-2-vincent.donnefort@arm.com
---
 kernel/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1b6302e..9121edf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2207,6 +2207,11 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	if (ret)
 		return ret;
 
+	if (fail == CPUHP_INVALID) {
+		st->fail = fail;
+		return count;
+	}
+
 	if (fail < CPUHP_OFFLINE || fail > CPUHP_ONLINE)
 		return -EINVAL;
 
