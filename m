Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB32B28638B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgJGQUS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44636 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgJGQUQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:16 -0400
Date:   Wed, 07 Oct 2020 16:20:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOs0I47O69gIocdsK/+LvMx1GEKrs8VHdsFCSNTJt1o=;
        b=bvDXTybUKGanfdMe9p2JGJWU6fm8D0NgTmf90OGFpDn74e013mJRKH742LUwoUwFRKtobY
        85xyDqOn47qlRcG+c24J9olPrX1zUQbo9fQY8s+AJYDY6lQdqzz9DSk2lQunMfsd4eZpPq
        rpnG1+NMSaw1QcAy7NuCc+5iTNIkNdwH2bplekEsl/L4d4JXLxXE/PZ9unnzxbLCqT9qZB
        689TLMJRUtLGQBPgJPDOsrXB5IYacCEob6kFk8p9jzPzKdb2vErIlgkA2NBv+9IiqYYcg6
        IHZ+fbAt3B9z1d8Gp0Qz6tejlOx0uQxAY2Zz0NLVh5oM+bOIywqBzfUr9Lynww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KOs0I47O69gIocdsK/+LvMx1GEKrs8VHdsFCSNTJt1o=;
        b=ynb06beTtpSaH6DhxGBlZaZV0Lot28FOJrgoBDbK7OUdZEisMn0+AXQrZEEgmyf4QA5F4P
        XEoT+EranzmaEmCg==
From:   "tip-bot2 for Paul Bolle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomics: Check atomic-arch-fallback.h too
Cc:     Paul Bolle <pebolle@tiscali.nl>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001202028.1048418-1-pebolle@tiscali.nl>
References: <20201001202028.1048418-1-pebolle@tiscali.nl>
MIME-Version: 1.0
Message-ID: <160208761381.7002.4634156458963200039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d89d5f855f84ccf3f7e648813b4bb95c780bd7cd
Gitweb:        https://git.kernel.org/tip/d89d5f855f84ccf3f7e648813b4bb95c780bd7cd
Author:        Paul Bolle <pebolle@tiscali.nl>
AuthorDate:    Thu, 01 Oct 2020 22:20:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Oct 2020 18:14:14 +02:00

locking/atomics: Check atomic-arch-fallback.h too

The sha1sum of include/linux/atomic-arch-fallback.h isn't checked by
check-atomics.sh. It's not clear why it's skipped so let's check it too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/20201001202028.1048418-1-pebolle@tiscali.nl
---
 scripts/atomic/check-atomics.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 8378c63..82748d4 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -16,6 +16,7 @@ fi
 cat <<EOF |
 asm-generic/atomic-instrumented.h
 asm-generic/atomic-long.h
+linux/atomic-arch-fallback.h
 linux/atomic-fallback.h
 EOF
 while read header; do
