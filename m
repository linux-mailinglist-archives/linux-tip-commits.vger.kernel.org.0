Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 972CC80ABC2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423521F2119B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9C3B189;
	Fri,  8 Dec 2023 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GRKKFx0O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7GCNvhFW"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C555B199B;
	Fri,  8 Dec 2023 10:13:05 -0800 (PST)
Date: Fri, 08 Dec 2023 18:13:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mRgMpEtOSJBHDWGivEkUzrK1mBwzcnA7ULdr1D3O8kk=;
	b=GRKKFx0OhwyKZC8SiqPEB21TfTXQe066OGHnGnkm5FN0JVCm2+uSToyjKl3XBU3buzDGD2
	73GGP9h+yAtGpD/sktTFX7CDH33eQAZUx1iMXHILO8t4p1Q/WnEo5BmYOvvk+2zzM9eBz7
	fQWERD/e2x08m1q5wvPVyos2vd6LkVBJ7lEh2gce2l30f5TWYxFq6Wniqw+rZQ+zeX09rs
	LWYQRdRkMoJP0QBCqmPT4NGlV65XAA6nGaO8ASZpmIUhTRtdRY+xOG6cB7ZXf8xFM9wFLy
	8o+acu5AHi1TlWkRkTihQm07h1D9436ZuuUT8HkX6vzD7Ym0VzxSAJbSk76B3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=mRgMpEtOSJBHDWGivEkUzrK1mBwzcnA7ULdr1D3O8kk=;
	b=7GCNvhFWlJ2j4apzg+PtMg3sa6R9HAcjSIl1BQ98xe66xmQ7VBozQTyiSYuBuug1NozCug
	23WC4LRRg+yS4NDA==
From: "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Fix uninitialized pointer dereferences
 in encl_get_entry
Cc: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170205918374.398.6959285189365623759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     b84fc2e0139ba4b23b8039bd7cfd242894fe8f8b
Gitweb:        https://git.kernel.org/tip/b84fc2e0139ba4b23b8039bd7cfd242894fe8f8b
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:43 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:26 -08:00

selftests/sgx: Fix uninitialized pointer dereferences in encl_get_entry

Ensure sym_tab and sym_names are zero-initialized and add an early-out
condition in the unlikely (erroneous) case that the enclave ELF file would
not contain a symbol table.

This addresses -Werror=maybe-uninitialized compiler warnings for gcc -O2.

Fixes: 33c5aac3bf32 ("selftests/sgx: Test complete changing of page type flow")
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-3-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/load.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 94bdeac..c9f658e 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -136,11 +136,11 @@ static bool encl_ioc_add_pages(struct encl *encl, struct encl_segment *seg)
  */
 uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 {
+	Elf64_Sym *symtab = NULL;
+	char *sym_names = NULL;
 	Elf64_Shdr *sections;
-	Elf64_Sym *symtab;
 	Elf64_Ehdr *ehdr;
-	char *sym_names;
-	int num_sym;
+	int num_sym = 0;
 	int i;
 
 	ehdr = encl->bin;
@@ -161,6 +161,9 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
 		}
 	}
 
+	if (!symtab || !sym_names)
+		return 0;
+
 	for (i = 0; i < num_sym; i++) {
 		Elf64_Sym *sym = &symtab[i];
 

