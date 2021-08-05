Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F093E1167
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhHEJfC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239354AbhHEJew (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63B0C061798;
        Thu,  5 Aug 2021 02:34:38 -0700 (PDT)
Date:   Thu, 05 Aug 2021 09:34:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1q+dEXnSlNfc2kxWteFAidNauBz+KoBleorbpxKXOw=;
        b=O2sQZeEN4MZfLJFx+dPbNdX6hh8CbPJvMyxClNMwQstzqTGvjljwIh6lECZGuWddh7+Fwr
        ur+6imKCKw3+y8fkhTKEpYmT9u3cTH2exlBgsJ5vi6TOx0egsyxOBCgG0BlJ0teE1TJm+C
        zAV1UMvLnDQgpwhjW/lT+V28Z4MFzgtPvOfhxFkxwofS6LBHN3Ex8B5zY3xFrz2gljrO9l
        8hmMHILdcolRMZ1htGtPDPb5QKsO1EBtx0u3a22zAtGuaMirhn3dG+L4lGD16fHe/hHf5l
        ZyYhyZdYdu9ExyrRFq9+P5qB29uKtnnG8ona6CfC/nlxRAJEi5v2oYBA8g9jTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156077;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1q+dEXnSlNfc2kxWteFAidNauBz+KoBleorbpxKXOw=;
        b=RKCGGAlOFV6cxm+JEtNn6r1sTVGhlCgzARdBq6uNGAtuQ/CMWd3sPBw0taXVz56n9/Zr4m
        2QAOr9FSMtQ+95BQ==
From:   tip-bot2 for Mika =?utf-8?q?Penttil=C3=A4?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Fix is_core_idle()
Cc:     mika.penttila@gmail.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pankaj Gupta <pankaj.gupta@ionos.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210722063946.28951-1-mika.penttila@gmail.com>
References: <20210722063946.28951-1-mika.penttila@gmail.com>
MIME-Version: 1.0
Message-ID: <162815607690.395.492375170738086086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1c6829cfd3d5124b125e6df41158665aea413b35
Gitweb:        https://git.kernel.org/tip/1c6829cfd3d5124b125e6df41158665aea4=
13b35
Author:        Mika Penttil=C3=A4 <mika.penttila@gmail.com>
AuthorDate:    Thu, 22 Jul 2021 09:39:46 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:43 +02:00

sched/numa: Fix is_core_idle()

Use the loop variable instead of the function argument to test the
other SMT siblings for idle.

Fixes: ff7db0bf24db ("sched/numa: Prefer using an idle CPU as a migration tar=
get instead of comparing tasks")
Signed-off-by: Mika Penttil=C3=A4 <mika.penttila@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Acked-by: Pankaj Gupta <pankaj.gupta@ionos.com>
Link: https://lkml.kernel.org/r/20210722063946.28951-1-mika.penttila@gmail.com
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 11d2294..13c3fd4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1486,7 +1486,7 @@ static inline bool is_core_idle(int cpu)
 		if (cpu =3D=3D sibling)
 			continue;
=20
-		if (!idle_cpu(cpu))
+		if (!idle_cpu(sibling))
 			return false;
 	}
 #endif
