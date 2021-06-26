Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F483B5021
	for <lists+linux-tip-commits@lfdr.de>; Sat, 26 Jun 2021 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFZUwS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 26 Jun 2021 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFZUwS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 26 Jun 2021 16:52:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E91C061574;
        Sat, 26 Jun 2021 13:49:55 -0700 (PDT)
Date:   Sat, 26 Jun 2021 20:49:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624740591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fkNDRwD+9YQ86N3dSd8BIzKrxCgJt2LslfoixRBHjKI=;
        b=hpnLMS+f0fyngm+lbSo1sX1rsXyX+txZtHWR6NXH7Cn6ioHQkmAFDhrQjjxNwiZxq9WgWD
        FoZgpI8t4c5uaoUqsg64DDjh3tGNn6CIvOvmqeaZxlU/UlI5UWF0qRPhf2N9XMMmnrUZCW
        f+ELlLebLRF+rnwXUVWrth72yxDrUueckD14O8su/pY14ogMnf7dSI10luSPhqsdMwxn4q
        ptX15KWsmR3emigkjX0rSIFr3tTJSMaz/guh6Db1qv2F5iyCMiv7e959anH/Qi18IAC9od
        5TRtzSeallv+1akDLaWT2/uhO/sxRmZFN1snXIxCxpsMWEpLLj831OsjCyD+lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624740591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fkNDRwD+9YQ86N3dSd8BIzKrxCgJt2LslfoixRBHjKI=;
        b=y29ZGSREQAvIS7muFkE2EK5GPh3cLnokJq/K4zp14VD8EWQm5cwU54ee7MrziuLwD97Pi0
        k4U4lPLu7ZylzrBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/kunit: Add missing MODULE_LICENSE()
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162474059066.395.17544610641097100087.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     34c7342ac1b4e496315fb615d2a1309df8400403
Gitweb:        https://git.kernel.org/tip/34c7342ac1b4e496315fb615d2a1309df8400403
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 26 Jun 2021 22:44:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 26 Jun 2021 22:47:32 +02:00

time/kunit: Add missing MODULE_LICENSE()

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/time_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 341ebfa..a064a7c 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -96,3 +96,4 @@ static struct kunit_suite time_test_suite = {
 };
 
 kunit_test_suite(time_test_suite);
+MODULE_LICENSE(GPL);
