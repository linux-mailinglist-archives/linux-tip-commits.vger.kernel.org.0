Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD81035B4B2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhDKNnj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:43:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33006 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKNni (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:38 -0400
Date:   Sun, 11 Apr 2021 13:43:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=deFofvz+2TZQTWojiTY9Wi4kKF381pRfy/JSMKyy8PI=;
        b=Z896urNsiE4q0z3QMv1mUmo4zQUgzbqYE3TrNwOhSGG8semio6P3PaMDaZUnDkRSYrYf5r
        rk4t+Oms0BTHq7UDVy/3byTQ/aw3BpMp8ILrC9h4BisVo0JbqlSdYtmxmDieH1VTtNZp6X
        dAPiDxoHmFdxjT+WmZe6Vx2HgIXZS5Tb3OIw99cN21XDJM+Fb8gqFJOqwcrPGbg8mdL/3A
        ObMlKJSskRsqHbMVtHThWV9ZnBXhgK+I8L6FbjFPgd7ikQ3y19oxchI+QZusPOsisXq/8b
        sQegUDmLkTMJMHvZfUm7hgchOH2F0ULpLVHOkClRw3roxZBtE+G0jf/z6suFXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=deFofvz+2TZQTWojiTY9Wi4kKF381pRfy/JSMKyy8PI=;
        b=MFarJsXjqPxVeQmjTtul/VDCR00mpac5iQJFtMS4fjPjvEPELXQHUy9xWkU6DdkRMCoKue
        gh1pEnJIxu6rhaCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Fix kvm.sh --datestamp regex check
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814859882.29796.9200989877074586252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     114e4a4b4884c14ebd35874cbe3e1ca0d38efa5d
Gitweb:        https://git.kernel.org/tip/114e4a4b4884c14ebd35874cbe3e1ca0d38efa5d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 27 Feb 2021 20:55:57 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:21 -07:00

torture: Fix kvm.sh --datestamp regex check

Some versions of grep are happy to interpret a nonsensically placed "-"
within a "[]" pattern as a dash, while others give an error message.
This commit therefore places the "-" at the end of the expression where
it was supposed to be in the first place.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 0add163..6bf00a0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -120,7 +120,7 @@ do
 		shift
 		;;
 	--datestamp)
-		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._-/]*$' '^--'
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._/-]*$' '^--'
 		ds=$2
 		shift
 		;;
