Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F728E4D5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Oct 2020 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbgJNQuu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 14 Oct 2020 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388548AbgJNQuu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 14 Oct 2020 12:50:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171ADC061755;
        Wed, 14 Oct 2020 09:50:50 -0700 (PDT)
Date:   Wed, 14 Oct 2020 16:50:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602694248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptfk5DkTFy7eOA62ShBszQ8F88jZO0h8cmhLJol/6ps=;
        b=VqTMHEPaxISZAStkmZxW9JceTl9fRtqbv0WCwJ5/PgvceLq6lZ8qf4biy8rVmA2H4WHIts
        UNuGFtpQbCFy0BZ+pwTQQpo8VqIHDD4nrwZfR3CMSD5TlKeBfBuFGBMC1v1nyPUztxY9FO
        LXOJz+NXPCdOI4MSIGsjfQzFISSqtFmEH/bnK+itCvQeC9tBJCWe8gxNN9qgNAgWKbcVSp
        rKpx5zkgHTW6pdsGbklaZlnqJEa3NY0zemWcdE4mxXmfyhhGiOJP7IQt9e4p8Vss6EmOC9
        0+i4bdVjarzrYn/Iiu1k1I2nJkLXFPpNXePGR6OV0zphA7whqs0lanMn09szIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602694248;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptfk5DkTFy7eOA62ShBszQ8F88jZO0h8cmhLJol/6ps=;
        b=gLdeXXCc8BpeRYiYyyshmtq7/D+BL8xwAn2KoJymG/xth/qkDSwY9SeFmy1FI8Dw7hNdTN
        hoES3HY3cxxB8xAw==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/seqlocks: Fix kernel-doc warnings
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3Ca59144cdaadf7fdf1fe5d55d0e1575abbf1c0cb3=2E16025?=
 =?utf-8?q?90106=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3Ca59144cdaadf7fdf1fe5d55d0e1575abbf1c0cb3=2E160259?=
 =?utf-8?q?0106=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160269424622.7002.46799787422984757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     ed3e453798d4f81c99056aa09fcd79d0874a60fd
Gitweb:        https://git.kernel.org/tip/ed3e453798d4f81c99056aa09fcd79d0874a60fd
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 13 Oct 2020 14:14:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 14 Oct 2020 18:07:50 +02:00

locking/seqlocks: Fix kernel-doc warnings

Right now, seqlock.h produces kernel-doc warnings:

	./include/linux/seqlock.h:181: error: Cannot parse typedef!

Convert it to a plain comment to avoid confusing kernel-doc.

Fixes: a8772dccb2ec ("seqlock: Fold seqcount_LOCKNAME_t definition")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/a59144cdaadf7fdf1fe5d55d0e1575abbf1c0cb3.1602590106.git.mchehab+huawei@kernel.org
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ac5b07f..cbfc78b 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -154,7 +154,7 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 #define __SEQ_LOCK(expr)
 #endif
 
-/**
+/*
  * typedef seqcount_LOCKNAME_t - sequence counter with LOCKNAME associated
  * @seqcount:	The real sequence counter
  * @lock:	Pointer to the associated lock
