Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3930D292C14
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 Oct 2020 19:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgJSRCm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 19 Oct 2020 13:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgJSRCm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 19 Oct 2020 13:02:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20329C0613D0;
        Mon, 19 Oct 2020 10:02:42 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:02:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603126960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klSXRhsQqqqtry06bZsmSHSzMiP3z7VwD9kbHwXwStQ=;
        b=YJmbtEm6tCVxr9abVLlSgyQZlt7FXiU4UZKUGYQlREXHPp75oc+JEFtUktNcC1w+94D1s8
        ezKj/SWH7RlvujOr7dmjWVHe200FUqCXFSCvhT3snNHrS9zeDtI5cdKU4IR0BEuM/XYBgr
        TG4XhCEz81rVzWDfIKy9K3KwxzojJfzBXkcFsX6A8Xiio0OhXL9T/jRW2pgnTzCHZ6po99
        Ghpub0NjQAuAYarHOxM7EfgAw+KTuhtz7tgXwqXzG2+TeVK0kIc3KAbKyMWzevbtazfOpC
        tKKcCP5nK9i0qpt3EqQh4SM+Hht+8ZSEox2pMbkIpKm/PONR0/6A6f/+n//U9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603126960;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=klSXRhsQqqqtry06bZsmSHSzMiP3z7VwD9kbHwXwStQ=;
        b=jtHZyAhBQ74skYYGCC92UL5gR7ciLevpyY/FSkUroxxNXYD7B/GOnpfi39HP36M9t7QWyL
        J2Kgfe81nfgcRPAw==
From:   "tip-bot2 for Al Grant" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: correct SNOOPX field offset
Cc:     Al Grant <al.grant@foss.arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com>
References: <4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com>
MIME-Version: 1.0
Message-ID: <160312695895.7002.2602979482194317435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     04de3266214453deb5f1d7849a66313e351af8cc
Gitweb:        https://git.kernel.org/tip/04de3266214453deb5f1d7849a66313e351af8cc
Author:        Al Grant <al.grant@foss.arm.com>
AuthorDate:    Mon, 21 Sep 2020 21:46:37 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Oct 2020 18:51:19 +02:00

perf: correct SNOOPX field offset

perf_event.h has macros that define the field offsets in the
data_src bitmask in perf records. The SNOOPX and REMOTE offsets
were both 37. These are distinct fields, and the bitfield layout
in perf_mem_data_src confirms that SNOOPX should be at offset 38.

Fixes: 52839e653b5629bd ("perf tools: Add support for printing new mem_info encodings")
Signed-off-by: Al Grant <al.grant@foss.arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/4ac9f5cc-4388-b34a-9999-418a4099415d@foss.arm.com
---
 include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 077e7ee..b95d3c4 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1196,7 +1196,7 @@ union perf_mem_data_src {
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
 /* 1 free */
-#define PERF_MEM_SNOOPX_SHIFT	37
+#define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
 #define PERF_MEM_LOCK_NA	0x01 /* not available */
