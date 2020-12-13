Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158742D8FF2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbgLMTC1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbgLMTCI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:08 -0500
Date:   Sun, 13 Dec 2020 19:01:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZBlgjp/mKPbUn6nlvSihCnWvqzwn2fwoMZ728MdVXoY=;
        b=euhX23CP9x7N2nTPkIktUk0OCIdt85ZtscjUVys1jKiy2+MzdiMAebWnUKiy6RtD9Eb2UD
        fOuyXPystEnhBLE5toMsDmpo07obDR3D/tsuRXzUrsW1CdUCAGUcPvweLbBuj2kgYLQijf
        0T9W2CZzlH3NI1yiREX/Cy3SpAG2aOjt6C1iKs5+Bwir0gmnHTCGRNCsx0K/ngCewvFLFs
        an+4p40M5ii+JYDtLbIaZXwmFCQJNSr7kbWL9rKuVY+tUBKnBZ4i9Ed51onLVrx6ADaAIP
        Lr5kOESpz8VtRTF2CE+bsZYJwsbToAw/2MZqPul1DS8i7iW2BcwHWcZBcYmM+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZBlgjp/mKPbUn6nlvSihCnWvqzwn2fwoMZ728MdVXoY=;
        b=gYWfgYfFSTnQP3f98bbUGQfibdEs50qfVwFbU14vF1TQQbsxcYbh/LYyZ/fzCssONxTvMf
        V44lw/+McQBUb2Cw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] kcsan: selftest: Ensure that address is at least PAGE_SIZE
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607514.3364.17352273635644524113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4761612ffe3c1655e58f1ef9cf867c6f67d46fe2
Gitweb:        https://git.kernel.org/tip/4761612ffe3c1655e58f1ef9cf867c6f67d46fe2
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 22 Oct 2020 13:45:52 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:08:50 -08:00

kcsan: selftest: Ensure that address is at least PAGE_SIZE

In preparation of supporting only addresses not within the NULL page,
change the selftest to never use addresses that are less than PAGE_SIZE.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/selftest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index d98bc20..9014a3a 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -33,6 +33,9 @@ static bool test_encode_decode(void)
 		unsigned long addr;
 
 		prandom_bytes(&addr, sizeof(addr));
+		if (addr < PAGE_SIZE)
+			addr = PAGE_SIZE;
+
 		if (WARN_ON(!check_encodable(addr, size)))
 			return false;
 
