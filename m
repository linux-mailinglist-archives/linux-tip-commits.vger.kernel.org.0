Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5AB28823E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbgJIGf5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55740 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbgJIGft (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:49 -0400
Date:   Fri, 09 Oct 2020 06:35:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bdsy+VmfcLeHvYidRAKXlWqld/0y4tGdKJmGcFefHI4=;
        b=M/82gyCKXLL4j4ZN8L+y2hUjuw8+ugEgdtar0inhCWL3t5uZZ7Mhaxrx7nKEaVBei93R/L
        s8wkFDIx8aTJotBaes22hDGR9TlGKfZ0OM4cnQ2XjTxfE4cZ5l9yV1P91LYj8z6XQ1EsmS
        ukWCJZQyAia+oBULsGa6ew4jVYwYCA2p+U3FIFRbCdhee2ycWeD7LntJ3ctQmr7qKwT5n7
        EzbrgSK00GqwUtQsdDn77hdIL/q5IB9TVse/tH50DWj+Rf0SYMIWjQNLLz4GlBOjmBVXBw
        SJQtEizi+WG0KXaI1zAso1bpXXZRxOYPlccIDuJLsgrNKHWD7Fo0jQWcZwnIKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bdsy+VmfcLeHvYidRAKXlWqld/0y4tGdKJmGcFefHI4=;
        b=+4OOlcpAw0+svbpdMKX4fZ13v70Z7vqTe03nB8V94GwnC0sFQZga/Ss8X+DtVaHuZjpGVi
        LhPbLUIi9JHfcvAA==
From:   "tip-bot2 for Tobias Klauser" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs: Fix typo in synchronize_rcu() function name
Cc:     Tobias Klauser <tklauser@distanz.ch>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222534661.7002.3876459463895026010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     77f808607a62c3685381a5732a88b30bad8893b5
Gitweb:        https://git.kernel.org/tip/77f808607a62c3685381a5732a88b30bad8893b5
Author:        Tobias Klauser <tklauser@distanz.ch>
AuthorDate:    Thu, 02 Jul 2020 18:28:10 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 14:29:16 -07:00

docs: Fix typo in synchronize_rcu() function name

s/sychronize_rcu/synchronize_rcu/

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index c7f147b..fb3ff76 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -360,7 +360,7 @@ order to amortize their overhead over many uses of the corresponding APIs.
 
 There are at least three flavors of RCU usage in the Linux kernel. The diagram
 above shows the most common one. On the updater side, the rcu_assign_pointer(),
-sychronize_rcu() and call_rcu() primitives used are the same for all three
+synchronize_rcu() and call_rcu() primitives used are the same for all three
 flavors. However for protection (on the reader side), the primitives used vary
 depending on the flavor:
 
