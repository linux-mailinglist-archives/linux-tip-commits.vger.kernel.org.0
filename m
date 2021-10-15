Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144EC42EDFD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhJOJrT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237718AbhJOJrM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:12 -0400
Date:   Fri, 15 Oct 2021 09:45:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdisDVVQ49/99loxUywx5OfIDt796wNaVlm8xETRrRk=;
        b=XifGtNWCY7DQDKq7gP38EldUR7rKLN31f7Vu9Aoz9LxjvjHsYvjviiZJhDCF196jYSCSPC
        m52c/c2WA4k1GspHK0VMo6vgjYtpET/fxgQo5STfg/5ArIafWR2eNWHRXDGQiyaYNvRBVA
        EkkxvOl+5k4oHVeAaBwuYM7f/9s3ruqjupzwFbFYDu4iYkQAoeqY9tKfYWuSatEbQrvaDn
        dVrrbkzvQ5mcwTEG5cXbhTsXQth7g+G2UfFbI+ad72kscOFxyyv8n/xO70LvTHt5pSHbEx
        2RLCbuzuryaAffV2dEQOsjL9LvN68x2FvtBsanaVrWpA91OWtSFHCbSom2Oh8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291105;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdisDVVQ49/99loxUywx5OfIDt796wNaVlm8xETRrRk=;
        b=8Ci8ZIMCaZlu6fBl3yKtdKK11VCZtb6Be2uqE1XlVSrCkNaUYsovvUTyDGmoUfxgPeg/KT
        7owjX/JdJeUfE/Ag==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] leaking_addresses: Always print a trailing newline
Cc:     Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211008111626.151570317@infradead.org>
References: <20211008111626.151570317@infradead.org>
MIME-Version: 1.0
Message-ID: <163429110440.25758.529304583777426883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cf2a85efdade117e2169d6e26641016cbbf03ef0
Gitweb:        https://git.kernel.org/tip/cf2a85efdade117e2169d6e26641016cbbf03ef0
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 29 Sep 2021 15:02:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:13 +02:00

leaking_addresses: Always print a trailing newline

For files that lack trailing newlines and match a leaking address (e.g.
wchan[1]), the leaking_addresses.pl report would run together with the
next line, making things look corrupted.

Unconditionally remove the newline on input, and write it back out on
output.

[1] https://lore.kernel.org/all/20210103142726.GC30643@xsang-OptiPlex-9020/

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211008111626.151570317@infradead.org
---
 scripts/leaking_addresses.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index b2d8b8a..8f636a2 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -455,8 +455,9 @@ sub parse_file
 
 	open my $fh, "<", $file or return;
 	while ( <$fh> ) {
+		chomp;
 		if (may_leak_address($_)) {
-			print $file . ': ' . $_;
+			printf("$file: $_\n");
 		}
 	}
 	close $fh;
