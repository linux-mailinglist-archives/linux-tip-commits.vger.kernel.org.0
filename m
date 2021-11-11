Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1044D687
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKKMZE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhKKMZE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:04 -0500
Date:   Thu, 11 Nov 2021 12:22:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtt68tMQNJUXpzYaWbt0FKFDw0AdSfumZhl982QNQnY=;
        b=IgVcT3IDfxJnz1QUVE4jFau7np5AkkTtwy23vaToaXXghAF5ZjaYmKW6N2yP2UzSo2Lce1
        BGKmmPhV5thc1PaCRXhOHS8QoQ3FLh5r68QW60Ue4Xn1iZS3ctSOtCmmKNbAOnS/M9DqSc
        lmOZvvYKoGAmB+Z1tc1LVunasejwyV0ITTQ6luYDP7VCUgMMphjaNLGSiR41HVWtSt8QCY
        TdWYWE0xQcOAzMgfDmNyIoILvWKkQYgY0cmtQHIZ93x5AkAiIHsd8sj0GxO90psStHgDNY
        phrRFb0gXZpwl8WzVU+wr6EzYYnNuI2f5sve1iyNGNhfv9EI4aOBzsoG0xAAGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtt68tMQNJUXpzYaWbt0FKFDw0AdSfumZhl982QNQnY=;
        b=HG3Scmq/yETlEc99NOSChxp+jdFZ5+Uv0JJTR3350i987F7tfCKbn6jsWtT+8nMiW+aClC
        eZLll8Ey5mVWjqAw==
From:   "tip-bot2 for Greg Thelen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Avoid put_page() when GUP fails
Cc:     Greg Thelen <gthelen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211111021814.757086-1-gthelen@google.com>
References: <20211111021814.757086-1-gthelen@google.com>
MIME-Version: 1.0
Message-ID: <163663333331.414.639840290224641315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4716023a8f6a0f4a28047f14dd7ebdc319606b84
Gitweb:        https://git.kernel.org/tip/4716023a8f6a0f4a28047f14dd7ebdc319606b84
Author:        Greg Thelen <gthelen@google.com>
AuthorDate:    Wed, 10 Nov 2021 18:18:14 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:34 +01:00

perf/core: Avoid put_page() when GUP fails

PEBS PERF_SAMPLE_PHYS_ADDR events use perf_virt_to_phys() to convert PMU
sampled virtual addresses to physical using get_user_page_fast_only()
and page_to_phys().

Some get_user_page_fast_only() error cases return false, indicating no
page reference, but still initialize the output page pointer with an
unreferenced page. In these error cases perf_virt_to_phys() calls
put_page(). This causes page reference count underflow, which can lead
to unintentional page sharing.

Fix perf_virt_to_phys() to only put_page() if get_user_page_fast_only()
returns a referenced page.

Fixes: fc7ce9c74c3ad ("perf/core, x86: Add PERF_SAMPLE_PHYS_ADDR")
Signed-off-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211111021814.757086-1-gthelen@google.com
---
 kernel/events/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f2253ea..523106a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7154,7 +7154,6 @@ void perf_output_sample(struct perf_output_handle *handle,
 static u64 perf_virt_to_phys(u64 virt)
 {
 	u64 phys_addr = 0;
-	struct page *p = NULL;
 
 	if (!virt)
 		return 0;
@@ -7173,14 +7172,15 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * If failed, leave phys_addr as 0.
 		 */
 		if (current->mm != NULL) {
+			struct page *p;
+
 			pagefault_disable();
-			if (get_user_page_fast_only(virt, 0, &p))
+			if (get_user_page_fast_only(virt, 0, &p)) {
 				phys_addr = page_to_phys(p) + virt % PAGE_SIZE;
+				put_page(p);
+			}
 			pagefault_enable();
 		}
-
-		if (p)
-			put_page(p);
 	}
 
 	return phys_addr;
