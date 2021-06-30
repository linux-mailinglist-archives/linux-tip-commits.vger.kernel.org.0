Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183403B8445
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbhF3NyA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:54:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33086 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbhF3NwJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:52:09 -0400
Date:   Wed, 30 Jun 2021 13:48:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OVYF6rcz5wlCrbLMYN3cPQM2s9aUhTFjgJ+LqNefDN8=;
        b=kxf5/g3zMKbgy5olwZz7ZFt6GUKHjNF1Z1oL4wv6PSkFDq2oIACs5p8955tk4F9kbBW8p5
        2HD/zF+aiGBAHVaKuxqbhFnF7Mwh08lsZf2CGbesXGDTmDVhAdeqgOcLy8OorNTs+7kiLo
        rVjDmmVVi7JLDAmiyr5979FMoIkUEpB0bmLJBtd9+0PQMKh3H4E7myU8KV98vFJwNhY2Ex
        U2vkEt7+mKpAbrLbLV+paOJj2EILCgRkA5IJk8wcqM7QBQ+QpFC6fMI6ddb9kEO9gOhMOq
        ypEof0Ws2ADI3/M1URG32t8R3/yXhOaoNzCKE2XfO76a/UUJFWhB1jX/7ndcEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060902;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=OVYF6rcz5wlCrbLMYN3cPQM2s9aUhTFjgJ+LqNefDN8=;
        b=k2IGEgEjvZxhTxEjz69+2XwiQPz6SWom6RvT0iorvjSwRyeYk2nDQip6aV4iwK1ufcoZ/3
        FeXSj6ARR4RHOCAw==
From:   tip-bot2 for =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] tools/memory-model: Fix
 smp_mb__after_spinlock() spelling
Cc:     bjorn.topel@intel.com, "Paul E. McKenney" <paulmck@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506090184.395.8692131748805186595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     d25fba0e34742f19b5ca307c60c4d260ca5a754a
Gitweb:        https://git.kernel.org/tip/d25fba0e34742f19b5ca307c60c4d260ca5=
a754a
Author:        Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
AuthorDate:    Fri, 05 Mar 2021 11:28:23 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:27:20 -07:00

tools/memory-model: Fix smp_mb__after_spinlock() spelling

A misspelled git-grep regex revealed that smp_mb__after_spinlock()
was misspelled in explanation.txt.  This commit adds the missing "_".

Fixes: 1c27b644c0fd ("Automate memory-barriers.txt; provide Linux-kernel memo=
ry model")
[ paulmck: Apply Alan Stern commit-log feedback. ]
Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/explanation.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-=
model/Documentation/explanation.txt
index f9d610d..5d72f31 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -2510,7 +2510,7 @@ they behave as follows:
 	smp_mb__after_atomic() orders po-earlier atomic updates and
 	the events preceding them against all po-later events;
=20
-	smp_mb_after_spinlock() orders po-earlier lock acquisition
+	smp_mb__after_spinlock() orders po-earlier lock acquisition
 	events and the events preceding them against all po-later
 	events.
=20
