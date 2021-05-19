Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B672138891C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244298AbhESIKa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:10:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244179AbhESIK2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:10:28 -0400
Date:   Wed, 19 May 2021 08:09:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13aSZm9uvvITPxgS5rz4U/aa+Zlrot3Vo5JIz4tLnXs=;
        b=ph3PhBN/nypSNZN0RO3bHq3q32i/M10+X+91ZQN/OqAZQebpBmJeHZInNyB45gzpkxXrc4
        WaBNFX3hp130l4asQAc7pBu9MSitfFRNeOfX4Fhev7i9X7ZV0QL++UmL8ErSrAHM+SVh+S
        BCFP8Z9tspQuAw9/4W54aAOG6gIOO+BsoRGEO7qK44ixCMIc6Dw7gnF2XJ11lCptZNXTqJ
        aodwBm4WI3uQxKJhFkbkmUiJTw04cmEId/IaPbeBsuKAM2jFKLahlINkgAnab2OhnYo6zT
        UoMpT5ANW/avB2FXdsELKeBxe/bvnqyyO4sFOHzHsDsPOBMw81tpeydBBHuizg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13aSZm9uvvITPxgS5rz4U/aa+Zlrot3Vo5JIz4tLnXs=;
        b=HRgi9WLmkVooQC7BnbJZ2He1keAaBhntNf+e8zKNgeVVQsHHSDUb+D4FtJrrZAqr300mKz
        fXu4NvgoCdEtfLBg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] delayacct: Document task_delayacct sysctl
Cc:     Mel Gorman <mgorman@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512114035.GH3672@suse.de>
References: <20210512114035.GH3672@suse.de>
MIME-Version: 1.0
Message-ID: <162141174718.29796.2047071574805504489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fcb501704554eebfd27e3220b0540997fd2b24a8
Gitweb:        https://git.kernel.org/tip/fcb501704554eebfd27e3220b0540997fd2b24a8
Author:        Mel Gorman <mgorman@suse.de>
AuthorDate:    Wed, 12 May 2021 12:40:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:53 +02:00

delayacct: Document task_delayacct sysctl

Update sysctl/kernel.rst.

Signed-off-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210512114035.GH3672@suse.de
---
 Documentation/admin-guide/sysctl/kernel.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 1d56a6b..ebd2f99 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1087,6 +1087,13 @@ Model available). If your platform happens to meet the
 requirements for EAS but you do not want to use it, change
 this value to 0.
 
+task_delayacct
+===============
+
+Enables/disables task delay accounting (see
+:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
+a small amount of overhead in the scheduler but is useful for debugging
+and performance tuning. It is required by some tools such as iotop.
 
 sched_schedstats
 ================
