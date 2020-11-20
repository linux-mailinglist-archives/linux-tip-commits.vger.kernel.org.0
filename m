Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5242BAA2D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgKTMeC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbgKTMeC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AF3C0613CF;
        Fri, 20 Nov 2020 04:34:02 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GH9+dmtOReJvFt5uJXm36DQ5ddX710bK7BYLhCfNTKI=;
        b=1lIjXEeLaagk0gw7wmzkfRsgeyuwuTHgjlZUsQ2EhYu2PVYgu480i0O/kj0wyzJS2MPAuV
        7lYDunibffESckbRkszksS40ooUOjna1ny921nRr8egvPwxXHJFZYdepaiXA3BU1cwYDGu
        vWAduKfrLx3hzy9SbIYg0Igd15dkKB66j9LCCVPvg12/6trl9GgKoFnfv8nWiH033jgwwl
        2Tc9mql2mcZyfJFOiW8EY0jV7Epg8DfLijLLyyBX2AdQnKpMFTg/7hTwMRBRznHW4lvv4w
        Bw8Sw2E3fDaoPrO/oIeV0QjuE9KV6oEXzkDH0HFybSOS8IuYxC8hVqMq1F3m8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GH9+dmtOReJvFt5uJXm36DQ5ddX710bK7BYLhCfNTKI=;
        b=TPSTucObabTbuzygka82YtwjQRRSyu6LBckvjbQl8ZIA2x28v/iAUmKzQz4pz+8j6LjzsO
        47v4p+BeWFCwnvDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] coccinelle: Remove broken check
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160587563778.11244.7037290441526713921.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     994ddefc2440c96cc8e1386b2bc23d4793f07eb4
Gitweb:        https://git.kernel.org/tip/994ddefc2440c96cc8e1386b2bc23d4793f07eb4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 09 Nov 2020 12:32:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:26:18 +01:00

coccinelle: Remove broken check

Get rid of the endless stream of patches that complain about:

  "WARNING: Assignment of 0/1 to bool variable"

Which is perfectly valid C.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/coccinelle/misc/boolinit.cocci | 195 +------------------------
 1 file changed, 195 deletions(-)
 delete mode 100644 scripts/coccinelle/misc/boolinit.cocci

diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
deleted file mode 100644
index fed6126..0000000
--- a/scripts/coccinelle/misc/boolinit.cocci
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/// Bool initializations should use true and false.  Bool tests don't need
-/// comparisons.  Based on contributions from Joe Perches, Rusty Russell
-/// and Bruce W Allan.
-///
-// Confidence: High
-// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
-// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
-// URL: http://coccinelle.lip6.fr/
-// Options: --include-headers
-
-virtual patch
-virtual context
-virtual org
-virtual report
-
-@boolok@
-symbol true,false;
-@@
-(
-true
-|
-false
-)
-
-@depends on patch@
-bool t;
-@@
-
-(
-- t == true
-+ t
-|
-- true == t
-+ t
-|
-- t != true
-+ !t
-|
-- true != t
-+ !t
-|
-- t == false
-+ !t
-|
-- false == t
-+ !t
-|
-- t != false
-+ t
-|
-- false != t
-+ t
-)
-
-@depends on patch disable is_zero, isnt_zero@
-bool t;
-@@
-
-(
-- t == 1
-+ t
-|
-- t != 1
-+ !t
-|
-- t == 0
-+ !t
-|
-- t != 0
-+ t
-)
-
-@depends on patch && boolok@
-bool b;
-@@
-(
- b =
-- 0
-+ false
-|
- b =
-- 1
-+ true
-)
-
-// ---------------------------------------------------------------------
-
-@r1 depends on !patch@
-bool t;
-position p;
-@@
-
-(
-* t@p == true
-|
-* true == t@p
-|
-* t@p != true
-|
-* true != t@p
-|
-* t@p == false
-|
-* false == t@p
-|
-* t@p != false
-|
-* false != t@p
-)
-
-@r2 depends on !patch disable is_zero, isnt_zero@
-bool t;
-position p;
-@@
-
-(
-* t@p == 1
-|
-* t@p != 1
-|
-* t@p == 0
-|
-* t@p != 0
-)
-
-@r3 depends on !patch && boolok@
-bool b;
-position p1;
-@@
-(
-*b@p1 = 0
-|
-*b@p1 = 1
-)
-
-@r4 depends on !patch@
-bool b;
-position p2;
-identifier i;
-constant c != {0,1};
-@@
-(
- b = i
-|
-*b@p2 = c
-)
-
-@script:python depends on org@
-p << r1.p;
-@@
-
-cocci.print_main("WARNING: Comparison to bool",p)
-
-@script:python depends on org@
-p << r2.p;
-@@
-
-cocci.print_main("WARNING: Comparison of 0/1 to bool variable",p)
-
-@script:python depends on org@
-p1 << r3.p1;
-@@
-
-cocci.print_main("WARNING: Assignment of 0/1 to bool variable",p1)
-
-@script:python depends on org@
-p2 << r4.p2;
-@@
-
-cocci.print_main("ERROR: Assignment of non-0/1 constant to bool variable",p2)
-
-@script:python depends on report@
-p << r1.p;
-@@
-
-coccilib.report.print_report(p[0],"WARNING: Comparison to bool")
-
-@script:python depends on report@
-p << r2.p;
-@@
-
-coccilib.report.print_report(p[0],"WARNING: Comparison of 0/1 to bool variable")
-
-@script:python depends on report@
-p1 << r3.p1;
-@@
-
-coccilib.report.print_report(p1[0],"WARNING: Assignment of 0/1 to bool variable")
-
-@script:python depends on report@
-p2 << r4.p2;
-@@
-
-coccilib.report.print_report(p2[0],"ERROR: Assignment of non-0/1 constant to bool variable")
