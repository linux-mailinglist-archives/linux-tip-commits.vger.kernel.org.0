Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B84244013
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Aug 2020 22:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHMUuE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 Aug 2020 16:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgHMUuD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 Aug 2020 16:50:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DFC061757;
        Thu, 13 Aug 2020 13:50:03 -0700 (PDT)
Date:   Thu, 13 Aug 2020 20:50:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597351801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWGVZ3Mpr3AqRCpLX8dy3EPmnqq4O3gEfxHcMXgcFMY=;
        b=tlw5RoRj1/2TbwxvnaEIRfrpr24lIM3If3j9YPT3FSTIu8gFn2n0NRnWpvDV5zecja5u1W
        KksyJtZzplLK7IPcdloH3SjgD2OSFJn66oYxmWRhhkU2aD5AhY2XYc/7pHvE+1TSv5CmYx
        co5IfbkvkATUx6TA0yACT+SWclHQ6kaRBah8oZKyxeozpTleCFpxbD0bTam5Ejqy7eDa39
        mDc2Ndhgs8hJsxveT9jWq8zB4vIa76lcApbw3ycswgnzKYY9FnHolMI+7Hw5o3iDP2PYfG
        arttBDbZFsrOybxYqCyk3HJawEHemWfBZsSUllLA/Pk45SmOc09QaGwpNVNqhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597351801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWGVZ3Mpr3AqRCpLX8dy3EPmnqq4O3gEfxHcMXgcFMY=;
        b=9APNVVop/JOjBjiYCTPpYuNMvv79WCGUcCto6+h9nf4lvAQf7dwUjlea7qsSs6rQmgxRDk
        SH4Bj2Y34XavqEAQ==
From:   "tip-bot2 for Huang Shijie" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] Documentation/locking/locktypes: Fix a typo
Cc:     Huang Shijie <sjhuang@iluvatar.ai>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200813060220.18199-1-sjhuang@iluvatar.ai>
References: <20200813060220.18199-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Message-ID: <159735180052.3192.8696596314516068127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     cb75c95c5262328bd4da3dd334f6826a3a34a979
Gitweb:        https://git.kernel.org/tip/cb75c95c5262328bd4da3dd334f6826a3a34a979
Author:        Huang Shijie <sjhuang@iluvatar.ai>
AuthorDate:    Thu, 13 Aug 2020 14:02:20 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Aug 2020 20:59:06 +02:00

Documentation/locking/locktypes: Fix a typo

We have three categories locks, not two.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200813060220.18199-1-sjhuang@iluvatar.ai
---
 Documentation/locking/locktypes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 1b577a8..4cefed8 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -10,7 +10,7 @@ Introduction
 ============
 
 The kernel provides a variety of locking primitives which can be divided
-into two categories:
+into three categories:
 
  - Sleeping locks
  - CPU local locks
