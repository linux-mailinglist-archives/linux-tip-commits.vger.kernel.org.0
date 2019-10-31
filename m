Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82649EAF56
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2019 12:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfJaLzK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 31 Oct 2019 07:55:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55314 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfJaLzI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:08 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92g-0002z9-0N; Thu, 31 Oct 2019 12:55:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E09421C04F3;
        Thu, 31 Oct 2019 12:55:01 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:01 -0000
From:   "tip-bot2 for Joel Fernandes (Google)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs: rcu: Increase toctree to 3
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290160.29376.11176319679384890270.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     76e771d188060d47f98e5634aee6333ab11673a4
Gitweb:        https://git.kernel.org/tip/76e771d188060d47f98e5634aee6333ab11673a4
Author:        Joel Fernandes (Google) <joel@joelfernandes.org>
AuthorDate:    Thu, 01 Aug 2019 17:39:20 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 29 Oct 2019 02:48:13 -07:00

docs: rcu: Increase toctree to 3

These documents are long and have various sections. Provide a good
toc nesting level.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 94427dc..5c99185 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -5,7 +5,7 @@ RCU concepts
 ============
 
 .. toctree::
-   :maxdepth: 1
+   :maxdepth: 3
 
    rcu
    listRCU
