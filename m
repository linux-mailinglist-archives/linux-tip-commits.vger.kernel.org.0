Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE243BB862
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGEH4b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhGEH40 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1487BC061760;
        Mon,  5 Jul 2021 00:53:50 -0700 (PDT)
Date:   Mon, 05 Jul 2021 07:53:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ybiyk5EbtHV29k0thx7yh7e5aVO8UJ5Wsi7miRvqtas=;
        b=KPhXtKvQS15cNqeMmQx79otvCPYo2KHdr+o23ukqUPiAPRFClpYTXD1rTIPGL5zfeSz3MZ
        5akXQh6Z1c8vf5aw8DeIJjEknLwHMo5BbFhlsC3YyrxQ8ZE1SQa3rW8qht0SJBuSuekNb/
        F3obHbkai/qwU4I3MEZYIlCfm2h6gkTG7tYbcqBDnZPNYovefWCnh3Y2K8VbypRJotrbX8
        ZyclsHk428yEVhrEemPwXXcdHF8SbUTctsJHa9+YP6V5xSOYNH/q+zujElLL2Pbi0kyvu0
        DK0rfIk0x16uFb80osTbXvCVDG1PDHT4RfkxrVmGqYjjPdel0JC/V96r13BRjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471628;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ybiyk5EbtHV29k0thx7yh7e5aVO8UJ5Wsi7miRvqtas=;
        b=Czyd9KU2F8C1g45VOx+idXcQgf0B9l3duyabvQWOHrMK65lB57d7aWi4lM2B3QoDK4Le/i
        pgQbIAy3CQENzQAw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Clean up error handling
 path of iio mapping
Cc:     gushengxian <gushengxian@yulong.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <40e66cf9-398b-20d7-ce4d-433be6e08921@linux.intel.com>
References: <40e66cf9-398b-20d7-ce4d-433be6e08921@linux.intel.com>
MIME-Version: 1.0
Message-ID: <162547162800.395.5965377579161888871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     d4ba0b06306a70c99a43f9d452886a86e2d3bd26
Gitweb:        https://git.kernel.org/tip/d4ba0b06306a70c99a43f9d452886a86e2d3bd26
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 24 Jun 2021 11:17:57 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:33 +02:00

perf/x86/intel/uncore: Clean up error handling path of iio mapping

The error handling path of iio mapping looks fragile. We already fixed
one issue caused by it, commit f797f05d917f ("perf/x86/intel/uncore:
Fix for iio mapping on Skylake Server"). Clean up the error handling
path and make the code robust.

Reported-by: gushengxian <gushengxian@yulong.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/40e66cf9-398b-20d7-ce4d-433be6e08921@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 3a75a2c..1f7bb48 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3789,11 +3789,11 @@ static int skx_iio_set_mapping(struct intel_uncore_type *type)
 	/* One more for NULL. */
 	attrs = kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
-		goto err;
+		goto clear_topology;
 
 	eas = kcalloc(uncore_max_dies(), sizeof(*eas), GFP_KERNEL);
 	if (!eas)
-		goto err;
+		goto clear_attrs;
 
 	for (die = 0; die < uncore_max_dies(); die++) {
 		sprintf(buf, "die%ld", die);
@@ -3814,7 +3814,9 @@ err:
 	for (; die >= 0; die--)
 		kfree(eas[die].attr.attr.name);
 	kfree(eas);
+clear_attrs:
 	kfree(attrs);
+clear_topology:
 	kfree(type->topology);
 clear_attr_update:
 	type->attr_update = NULL;
