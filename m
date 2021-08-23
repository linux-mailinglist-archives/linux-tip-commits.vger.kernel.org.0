Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E453F4498
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 07:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhHWFNJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 01:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhHWFNI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 01:13:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B5C061575;
        Sun, 22 Aug 2021 22:12:26 -0700 (PDT)
Date:   Mon, 23 Aug 2021 05:12:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629695542;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7kO42+nZL9e9p1MTgZCRoeLci+c9EeHs3/LG4KjRws=;
        b=2I1w9mr2hnXY1F3G0EFGkDPA+VLIKvsCUauEhO5HdIEjAaO38NsfpOzWplwpXodlQrcOm9
        CGX0nzAGqSBKfCYHy2onnVQF448JQkiuq3GvPnC8sEPaSORT4z/dgusUy1e47Hu80bG/Lb
        kGeYKftI8aqcFUePnNGa2MKtkdpxqkT98SpwXhgrwbddRYbL9Kivt5cfq4XwuFB+YTGzzl
        KIPLQt5Q9iFTxbaE7BG/0yWPfkoA5rfaCzjybk7VGMyvQTw2lyCAlaOh9HvpjWIzKoWvsh
        M7S039U5Wc0jPXjz/afd/t4034IQxOqqAlm/wkzUMHT3AhMgObRdn1B5Dryy8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629695542;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c7kO42+nZL9e9p1MTgZCRoeLci+c9EeHs3/LG4KjRws=;
        b=kVuD+6QbMPkeU9OL96PPpgbBpM7VYISmnZoXpezifvbRBwZCQLEVc7yP4BDizeqUlc38zL
        +/NFRQkUYZ0AyhCA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/tools/relocs: Mark die() with the printf
 function attr format
Cc:     Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YNnb6Q4QHtNYC049@zn.tnic>
References: <YNnb6Q4QHtNYC049@zn.tnic>
MIME-Version: 1.0
Message-ID: <162969554111.25758.6281531919074323037.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     03dca99e200f4d268f70079cf54e3b1200c9eb9d
Gitweb:        https://git.kernel.org/tip/03dca99e200f4d268f70079cf54e3b1200c9eb9d
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 25 Jun 2021 17:10:16 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 23 Aug 2021 05:58:02 +02:00

x86/tools/relocs: Mark die() with the printf function attr format

Mark die() as a function which accepts printf-style arguments so that
the compiler can typecheck them against the supplied format string.

Use the C99 inttypes.h format specifiers as relocs.c gets built for both
32- and 64-bit.

Original version of the patch by Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: http://lkml.kernel.org/r/YNnb6Q4QHtNYC049@zn.tnic
---
 arch/x86/tools/relocs.c | 37 ++++++++++++++++++++-----------------
 arch/x86/tools/relocs.h |  1 +
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 9ba700d..27c8220 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -26,6 +26,9 @@ static struct relocs relocs32;
 #if ELF_BITS == 64
 static struct relocs relocs32neg;
 static struct relocs relocs64;
+#define FMT PRIu64
+#else
+#define FMT PRIu32
 #endif
 
 struct section {
@@ -389,7 +392,7 @@ static void read_ehdr(FILE *fp)
 		Elf_Shdr shdr;
 
 		if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
-			die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n", ehdr.e_shoff, strerror(errno));
 
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
 			die("Cannot read initial ELF section header: %s\n", strerror(errno));
@@ -412,17 +415,17 @@ static void read_shdrs(FILE *fp)
 
 	secs = calloc(shnum, sizeof(struct section));
 	if (!secs) {
-		die("Unable to allocate %d section headers\n",
+		die("Unable to allocate %ld section headers\n",
 		    shnum);
 	}
 	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0) {
-		die("Seek to %d failed: %s\n",
-			ehdr.e_shoff, strerror(errno));
+		die("Seek to %" FMT " failed: %s\n",
+		    ehdr.e_shoff, strerror(errno));
 	}
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
 		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
-			die("Cannot read ELF section headers %d/%d: %s\n",
+			die("Cannot read ELF section headers %d/%ld: %s\n",
 			    i, shnum, strerror(errno));
 		sec->shdr.sh_name      = elf_word_to_cpu(shdr.sh_name);
 		sec->shdr.sh_type      = elf_word_to_cpu(shdr.sh_type);
@@ -450,12 +453,12 @@ static void read_strtabs(FILE *fp)
 		}
 		sec->strtab = malloc(sec->shdr.sh_size);
 		if (!sec->strtab) {
-			die("malloc of %d bytes for strtab failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %" FMT " bytes for strtab failed\n",
+			    sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -475,12 +478,12 @@ static void read_symtabs(FILE *fp)
 		}
 		sec->symtab = malloc(sec->shdr.sh_size);
 		if (!sec->symtab) {
-			die("malloc of %d bytes for symtab failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %" FMT " bytes for symtab failed\n",
+			    sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
@@ -508,12 +511,12 @@ static void read_relocs(FILE *fp)
 		}
 		sec->reltab = malloc(sec->shdr.sh_size);
 		if (!sec->reltab) {
-			die("malloc of %d bytes for relocs failed\n",
-				sec->shdr.sh_size);
+			die("malloc of %" FMT " bytes for relocs failed\n",
+			    sec->shdr.sh_size);
 		}
 		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %d failed: %s\n",
-				sec->shdr.sh_offset, strerror(errno));
+			die("Seek to %" FMT " failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
 		}
 		if (fread(sec->reltab, 1, sec->shdr.sh_size, fp)
 		    != sec->shdr.sh_size) {
diff --git a/arch/x86/tools/relocs.h b/arch/x86/tools/relocs.h
index 43c83c0..4c49c82 100644
--- a/arch/x86/tools/relocs.h
+++ b/arch/x86/tools/relocs.h
@@ -17,6 +17,7 @@
 #include <regex.h>
 #include <tools/le_byteshift.h>
 
+__attribute__((__format__(printf, 1, 2)))
 void die(char *fmt, ...) __attribute__((noreturn));
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
