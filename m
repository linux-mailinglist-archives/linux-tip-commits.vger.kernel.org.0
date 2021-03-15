Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A856D33C05C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhCOPsU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhCOPr6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:47:58 -0400
Date:   Mon, 15 Mar 2021 15:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+A2Ka7pqbBvuOpPPcSFVmW1XTrSdM8v04qFuXIJuFN0=;
        b=s2/hmQpI7msGpki0eV9gcbFfizkSMvn2k4AwhXItMZ1liSi7eO21iORmZTK3PYkVlgmdk9
        J+LX8DvLX19FA/dGZAKXutHO2yVZs7RO/FUObf9pguJi4JzAYvPY6vMo/S6ycZIqQK8poZ
        v1Mfo69/MLq0ifaXX0gbBA11WERMpCWrvQtLvf2Kck02ZeczzgdWTa16pPJPNPDgzSb2sM
        pxJsZSjaFcwA4asAi3e+3rulGpKxKOiX75hc8dW+Yjeu4gLeHEpHtx9jSAyvq0p//ZO0r7
        uP5zOa1e8Sdq/26+xgQJwLdZhNjLNZgrqSNZWczKoHIfwXHZ0NdXiHE8DPhA/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+A2Ka7pqbBvuOpPPcSFVmW1XTrSdM8v04qFuXIJuFN0=;
        b=ndPT8F2NQdeOstC5xdnv+XO1EfGqjknp6FKR5mt79afdvm7AA9bXT1MYgFFnfKfGi9et44
        KlmIGIiKUvgWrXCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/insn: Add a __ignore_sync_check__ marker
Cc:     Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-4-bp@alien8.de>
References: <20210304174237.31945-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326934.398.7431853570797650096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d30c7b820be5c4777fe6c3b0c21f9d0064251e51
Gitweb:        https://git.kernel.org/tip/d30c7b820be5c4777fe6c3b0c21f9d0064251e51
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 22 Feb 2021 13:34:40 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:00:57 +01:00

x86/insn: Add a __ignore_sync_check__ marker

Add an explicit __ignore_sync_check__ marker which will be used to mark
lines which are supposed to be ignored by file synchronization check
scripts, its advantage being that it explicitly denotes such lines in
the code.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20210304174237.31945-4-bp@alien8.de
---
 arch/x86/include/asm/inat.h       |  2 +-
 arch/x86/include/asm/insn.h       |  2 +-
 arch/x86/lib/inat.c               |  2 +-
 arch/x86/lib/insn.c               |  6 +++---
 tools/arch/x86/include/asm/inat.h |  2 +-
 tools/arch/x86/include/asm/insn.h |  2 +-
 tools/arch/x86/lib/inat.c         |  2 +-
 tools/arch/x86/lib/insn.c         |  6 +++---
 tools/objtool/sync-check.sh       | 17 +++++++++++++----
 tools/perf/check-headers.sh       | 15 +++++++++++----
 10 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 4cf2ad5..b56c574 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/inat_types.h>
+#include <asm/inat_types.h> /* __ignore_sync_check__ */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 95a448f..93f8460 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -9,7 +9,7 @@
 
 #include <asm/byteorder.h>
 /* insn_attr_t is defined in inat.h */
-#include <asm/inat.h>
+#include <asm/inat.h> /* __ignore_sync_check__ */
 
 #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
 
diff --git a/arch/x86/lib/inat.c b/arch/x86/lib/inat.c
index 12539fc..b0f3b2a 100644
--- a/arch/x86/lib/inat.c
+++ b/arch/x86/lib/inat.c
@@ -4,7 +4,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include <asm/insn.h>
+#include <asm/insn.h> /* __ignore_sync_check__ */
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 4d1640d..ed1e033 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -11,10 +11,10 @@
 #else
 #include <string.h>
 #endif
-#include <asm/inat.h>
-#include <asm/insn.h>
+#include <asm/inat.h> /*__ignore_sync_check__ */
+#include <asm/insn.h> /* __ignore_sync_check__ */
 
-#include <asm/emulate_prefix.h>
+#include <asm/emulate_prefix.h> /* __ignore_sync_check__ */
 
 #define leXX_to_cpu(t, r)						\
 ({									\
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 877827b..a610514 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -6,7 +6,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include "inat_types.h"
+#include "inat_types.h" /* __ignore_sync_check__ */
 
 /*
  * Internal bits. Don't use bitmasks directly, because these bits are
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index cc777c1..7e1239a 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -9,7 +9,7 @@
 
 #include <asm/byteorder.h>
 /* insn_attr_t is defined in inat.h */
-#include "inat.h"
+#include "inat.h" /* __ignore_sync_check__ */
 
 #if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
 
diff --git a/tools/arch/x86/lib/inat.c b/tools/arch/x86/lib/inat.c
index 4f5ed49..dfbcc64 100644
--- a/tools/arch/x86/lib/inat.c
+++ b/tools/arch/x86/lib/inat.c
@@ -4,7 +4,7 @@
  *
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
-#include "../include/asm/insn.h"
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
 /* Attribute tables are generated from opcode map */
 #include "inat-tables.c"
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 31afbf0..1174c43 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -11,10 +11,10 @@
 #else
 #include <string.h>
 #endif
-#include "../include/asm/inat.h"
-#include "../include/asm/insn.h"
+#include "../include/asm/inat.h" /* __ignore_sync_check__ */
+#include "../include/asm/insn.h" /* __ignore_sync_check__ */
 
-#include "../include/asm/emulate_prefix.h"
+#include "../include/asm/emulate_prefix.h" /* __ignore_sync_check__ */
 
 #define leXX_to_cpu(t, r)						\
 ({									\
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index 606a4b5..4bbabae 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -16,11 +16,14 @@ arch/x86/include/asm/emulate_prefix.h
 arch/x86/lib/x86-opcode-map.txt
 arch/x86/tools/gen-insn-attr-x86.awk
 include/linux/static_call_types.h
-arch/x86/include/asm/inat.h     -I '^#include [\"<]\(asm/\)*inat_types.h[\">]'
-arch/x86/include/asm/insn.h     -I '^#include [\"<]\(asm/\)*inat.h[\">]'
-arch/x86/lib/inat.c             -I '^#include [\"<]\(../include/\)*asm/insn.h[\">]'
-arch/x86/lib/insn.c             -I '^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]' -I '^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]'
 "
+
+SYNC_CHECK_FILES='
+arch/x86/include/asm/inat.h
+arch/x86/include/asm/insn.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+'
 fi
 
 check_2 () {
@@ -63,3 +66,9 @@ while read -r file_entry; do
 done <<EOF
 $FILES
 EOF
+
+if [ "$SRCARCH" = "x86" ]; then
+	for i in $SYNC_CHECK_FILES; do
+		check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+	done
+fi
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index dded93a..07857df 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -75,6 +75,13 @@ include/uapi/asm-generic/mman-common.h
 include/uapi/asm-generic/unistd.h
 '
 
+SYNC_CHECK_FILES='
+arch/x86/include/asm/inat.h
+arch/x86/include/asm/insn.h
+arch/x86/lib/inat.c
+arch/x86/lib/insn.c
+'
+
 # These copies are under tools/perf/trace/beauty/ as they are not used to in
 # building object files only by scripts in tools/perf/trace/beauty/ to generate
 # tables that then gets included in .c files for things like id->string syscall
@@ -129,6 +136,10 @@ for i in $FILES; do
   check $i -B
 done
 
+for i in $SYNC_CHECK_FILES; do
+  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
+done
+
 # diff with extra ignore lines
 check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memcpy_\(erms\|orig\))"'
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
@@ -137,10 +148,6 @@ check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
 check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
-check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
-check arch/x86/include/asm/insn.h     '-I "^#include [\"<]\(asm/\)*inat.h[\">]"'
-check arch/x86/lib/inat.c	      '-I "^#include [\"<]\(../include/\)*asm/insn.h[\">]"'
-check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in\(at\|sn\).h[\">]" -I "^#include [\"<]\(../include/\)*asm/emulate_prefix.h[\">]"'
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
