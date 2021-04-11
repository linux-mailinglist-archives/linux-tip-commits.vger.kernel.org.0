Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F9835B536
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbhDKNqE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:46:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbhDKNpH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:45:07 -0400
Date:   Sun, 11 Apr 2021 13:43:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vfE49Di8PMDtYSr//tHJ5DO0dL6m8ksil8Q1/BTSfFA=;
        b=1FDnMTGYTK4W9+a1AKUlgi7CCl8kSeJDXduan654jceq9hty/+Buw5DPzyUidprWm1Bg6p
        bUlmCYJLpugRWjGeNqkMc8rHcf9idc6WhAVtGdQBqxqXVs9xxzffFZtQCV8SM4g0D1Y68S
        bxlHGNcBjANfGbPUnf6n87twDOGn0orK4vLJ8Y9dNLISKYcwEnqgfFHCWds62O/DqWEYcb
        970OSYkFi9yeYcbrQm3KVELU8BtCFEoi6jaovkaC6MnO1VWbT5NyOAXxFSumW3ci1tMe7u
        T4hrNZKtuVDBTUDIPZxSMTotZtv7FgCK3yB6BoDI6e9sAbRAmCMrlpWiG86/hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vfE49Di8PMDtYSr//tHJ5DO0dL6m8ksil8Q1/BTSfFA=;
        b=BTslAbu8X28hmvk0XyL7MNUNvd39hB3+HJPAyQNqoQ3/86ktTDKzsAZzqKKE3SO2aYe+BO
        h4/c4TBMtvrL/vAA==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] doc: Update rcu_dereference.rst reference
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814863404.29796.460118746721532196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ba46b21bbdf8c1e8f054f44e7db7d6684720ef78
Gitweb:        https://git.kernel.org/tip/ba46b21bbdf8c1e8f054f44e7db7d6684720ef78
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Wed, 13 Jan 2021 11:59:20 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:29:22 -08:00

doc: Update rcu_dereference.rst reference

Changeset b00aedf978aa ("doc: Convert to rcu_dereference.txt to rcu_dereference.rst")
renamed: Documentation/RCU/rcu_dereference.txt
to: Documentation/RCU/rcu_dereference.rst.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/glossary.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
index b2da636..6f3d16d 100644
--- a/tools/memory-model/Documentation/glossary.txt
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -19,7 +19,7 @@ Address Dependency:  When the address of a later memory access is computed
 	 from the value returned by the rcu_dereference() on line 2, the
 	 address dependency extends from that rcu_dereference() to that
 	 "p->a".  In rare cases, optimizing compilers can destroy address
-	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
+	 dependencies.	Please see Documentation/RCU/rcu_dereference.rst
 	 for more information.
 
 	 See also "Control Dependency" and "Data Dependency".
