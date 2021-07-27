Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F223D779B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jul 2021 15:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhG0N6u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Jul 2021 09:58:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51436 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhG0N6s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Jul 2021 09:58:48 -0400
Date:   Tue, 27 Jul 2021 13:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627394327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxHMnGsPoRJHk/d/imLmrYAiUgFb84+uJgI8l+xlzb4=;
        b=oYOvbW/ii4kRLpi+aD/Jy5c07YIFIeCpXlBVjEbv25SrYlXXQ/KmPIChEALl9uroYKoISt
        UBZyH/UAjGuyVzn5huUnMJu+1vXvDl8uaN0WgOfw3xtEhWKLHBh4bMjTgD7NwuFNvs3EL1
        jBPZQow9PoJWPyZkOi8WmbOzJ2cJnpUq+YB47lJlmAdvSPO0ZRXjjyBmaPC03b2vPSEUaJ
        GiUKIElMiW5gWvEse8kD2T+xHmnR/+YJCjBn+LH8oQitexNkoEzts9elh2tmHa3TDg93ZA
        4iFE+H0xltTqQdAlwVNIQOBSlw86o1sJjib5USw69+8yJ/n6fVpVmjYEloE8cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627394327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxHMnGsPoRJHk/d/imLmrYAiUgFb84+uJgI8l+xlzb4=;
        b=MNE9DaxX58eaXUBvP9fgbx097PUk+mZrPXzKdI24kj0hQ5l1mmXfOvIZvnc51H0bsANJVV
        84HCeZ2QCMlZwtCw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: simplify ifdef generation
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713105253.7615-2-mark.rutland@arm.com>
References: <20210713105253.7615-2-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162739432644.395.8881842473322836307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     47401d94947d507ff9f33fccf490baf47638fb69
Gitweb:        https://git.kernel.org/tip/47401d94947d507ff9f33fccf490baf47638fb69
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 13 Jul 2021 11:52:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jul 2021 18:46:44 +02:00

locking/atomic: simplify ifdef generation

In gen-atomic-fallback.sh's gen_proto_order_variants(), we generate some
ifdeferry with:

| local basename="${arch}${atomic}_${pfx}${name}${sfx}"
| ...
| printf "#ifdef ${basename}\n"
| ...
| printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"

For clarity, use ${basename} for both sides, rather than open-coding the
string generation.

There is no change to any of the generated headers as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210713105253.7615-2-mark.rutland@arm.com
---
 scripts/atomic/gen-atomic-fallback.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 317a6ce..2601ff4 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -128,7 +128,7 @@ gen_proto_order_variants()
 	gen_basic_fallbacks "${basename}"
 
 	if [ ! -z "${template}" ]; then
-		printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"
+		printf "#endif /* ${basename} */\n\n"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
