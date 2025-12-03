Return-Path: <linux-tip-commits+bounces-7577-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8DCA0B02
	for <lists+linux-tip-commits@lfdr.de>; Wed, 03 Dec 2025 18:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1DEC31524C9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Dec 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABCC34B1A6;
	Wed,  3 Dec 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XknOAl1Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="umXJ/GAi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADE349B13;
	Wed,  3 Dec 2025 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780043; cv=none; b=hVwqZPUL5NyWC8j3G29/lJA5orPBkyOFRB54SDBvGZ508g9puoK9p7QeHtmZ1xrDd1I9NOrW1dBBuOV7XN8Sb3Tiave72ls2H8lI6Xqoe6ub2lA8RrvkhrFC8LP0MysO7IF/M3LV+LUYO7oe5+DzUoO55TPe2bSySqWWG32SQjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780043; c=relaxed/simple;
	bh=qhcvjLoWO0fyj8XhudxJ9gfatLYZRjCtTPl3tBuMi44=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YrB2Me1c/H63uzYBEzPidUbndR3312MBYulVxOARJ4ejqSsd0yc7SfqqKLA+qra8bfAuGiyyBdWhh9F1LKWV4cpZP3BLKFAr2iOkXwmY8Yj+nVfU3lZ63D5+hB+EfO7b6sh+68IXoRG5wTLviH3BLrtIBD30ZpJQDTNgh8cZiBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XknOAl1Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=umXJ/GAi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Dec 2025 16:40:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764780033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wx9MEMDm+3vPKPRuclTrv/cD8MFjzhVFUY5oldoLQM=;
	b=XknOAl1ZQEd4dymvBbeGrx0hAHwbnPICK31XCmJy1kWNwQvzdVDhg/CrjzjITzQaeih8T8
	lLGuwEeOcUu3sY1gnAxkYe04H/4jnJtgtf2Kue/HzLpL3IcCrMMeSxKrkARn0gcoUbAUZr
	XGAFN5VOg2Td/Kn+8AWnzJ9Ivx+4eVe8cTc216PtqnugN/KkKoSOH7pSmuIp8m84jdB3uh
	TVD4hWQCOD5WZQGcRshaLE4kFYwZcSQ7Fr98RWFXTBbJOTUha99E+gxqY5DI9UvDHU1lID
	XPzuk4lZ/81pXK26nimvVAFhfiCQC40JPcj7TzEnfrOrEcy+cP3/q/ep9/MZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764780033;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wx9MEMDm+3vPKPRuclTrv/cD8MFjzhVFUY5oldoLQM=;
	b=umXJ/GAizoZq9xbQpZbX3+IwRvxXal0+1kBjXnl93NL9plPONU/a6MywMsCutVAHrxv37n
	yabx3AijE0nT9qDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Add more robust signal error handling,
 detect and warn about stack overflows
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 David Laight <david.laight.linux@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <mi4tihk4dbncn7belrhp6ooudhpw4vdggerktu5333w3gqf3uf@vqlhc3y667mg>
References: <mi4tihk4dbncn7belrhp6ooudhpw4vdggerktu5333w3gqf3uf@vqlhc3y667mg>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176478002802.498.6977603369714924034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     0b528ad72c66f829ec2d0d89407d9b2917c0f8ae
Gitweb:        https://git.kernel.org/tip/0b528ad72c66f829ec2d0d89407d9b2917c=
0f8ae
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 15:01:17 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Dec 2025 17:31:53 +01:00

objtool: Add more robust signal error handling, detect and warn about stack o=
verflows

When the kernel build fails due to an objtool segfault, the error
message is a bit obtuse and confusing:

  make[5]: *** [scripts/Makefile.build:503: drivers/scsi/qla2xxx/qla2xxx.o] E=
rror 139
                                                                            ^=
^^^^^^^^
  make[5]: *** Deleting file 'drivers/scsi/qla2xxx/qla2xxx.o'
  make[4]: *** [scripts/Makefile.build:556: drivers/scsi/qla2xxx] Error 2
  make[3]: *** [scripts/Makefile.build:556: drivers/scsi] Error 2
  make[2]: *** [scripts/Makefile.build:556: drivers] Error 2
  make[1]: *** [/home/jpoimboe/git/linux/Makefile:2013: .] Error 2
  make: *** [Makefile:248: __sub-make] Error 2

Add a signal handler to objtool which prints an error message like if
the local stack has overflown (for which there's a chance as objtool
makes heavy use of recursion):

  drivers/scsi/qla2xxx/qla2xxx.o: error: SIGSEGV: objtool stack overflow!

or:

  drivers/scsi/qla2xxx/qla2xxx.o: error: SIGSEGV: objtool crash!

Also, re-raise the signal so the core dump still gets triggered.

[ mingo: Applied a build fix, added more comments and prettified the code. ]

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://patch.msgid.link/mi4tihk4dbncn7belrhp6ooudhpw4vdggerktu5333w3gq=
f3uf@vqlhc3y667mg
---
 tools/objtool/Build                     |   1 +-
 tools/objtool/include/objtool/objtool.h |   2 +-
 tools/objtool/objtool.c                 |   4 +-
 tools/objtool/signal.c                  | 135 +++++++++++++++++++++++-
 4 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 tools/objtool/signal.c

diff --git a/tools/objtool/Build b/tools/objtool/Build
index 9982e66..600da05 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -18,6 +18,7 @@ objtool-y +=3D libstring.o
 objtool-y +=3D libctype.o
 objtool-y +=3D str_error_r.o
 objtool-y +=3D librbtree.o
+objtool-y +=3D signal.o
=20
 $(OUTPUT)libstring.o: ../lib/string.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/=
objtool/objtool.h
index f7051bb..6dc12a5 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -41,6 +41,8 @@ struct objtool_file {
=20
 char *top_level_dir(const char *file);
=20
+int init_signal_handler(void);
+
 struct objtool_file *objtool_open_read(const char *_objname);
=20
 int objtool_pv_add(struct objtool_file *file, int idx, struct symbol *func);
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 3c26ed5..1c36221 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -104,11 +104,13 @@ char *top_level_dir(const char *file)
 	return str;
 }
=20
-
 int main(int argc, const char **argv)
 {
 	static const char *UNUSED =3D "OBJTOOL_NOT_IMPLEMENTED";
=20
+	if (init_signal_handler())
+		return -1;
+
 	/* libsubcmd init */
 	exec_cmd_init("objtool", UNUSED, UNUSED, UNUSED);
 	pager_init(UNUSED);
diff --git a/tools/objtool/signal.c b/tools/objtool/signal.c
new file mode 100644
index 0000000..af5c65c
--- /dev/null
+++ b/tools/objtool/signal.c
@@ -0,0 +1,135 @@
+/*
+ * signal.c: Register a sigaltstack for objtool, to be able to
+ *	     run a signal handler on a separate stack even if
+ *	     the main process stack has overflown. Print out
+ *	     stack overflow errors when this happens.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/resource.h>
+#include <string.h>
+
+#include <objtool/objtool.h>
+#include <objtool/warn.h>
+
+static unsigned long stack_limit;
+
+static bool is_stack_overflow(void *fault_addr)
+{
+	unsigned long fault =3D (unsigned long)fault_addr;
+
+	/* Check if fault is in the guard page just below the limit. */
+	return fault < stack_limit && fault >=3D stack_limit - 4096;
+}
+
+static void signal_handler(int sig_num, siginfo_t *info, void *context)
+{
+	struct sigaction sa_dfl =3D {0};
+	const char *sig_name;
+	char msg[256];
+	int msg_len;
+
+	switch (sig_num) {
+	case SIGSEGV:	sig_name =3D "SIGSEGV";		break;
+	case SIGBUS:	sig_name =3D "SIGBUS";		break;
+	case SIGILL:	sig_name =3D "SIGILL";		break;
+	case SIGABRT:	sig_name =3D "SIGABRT";		break;
+	default:	sig_name =3D "Unknown signal";	break;
+	}
+
+	if (is_stack_overflow(info->si_addr)) {
+		msg_len =3D snprintf(msg, sizeof(msg),
+				   "%s: error: %s: objtool stack overflow!\n",
+				   objname, sig_name);
+	} else {
+		msg_len =3D snprintf(msg, sizeof(msg),
+				   "%s: error: %s: objtool crash!\n",
+				   objname, sig_name);
+	}
+
+	msg_len =3D write(STDERR_FILENO, msg, msg_len);
+
+	/* Re-raise the signal to trigger the core dump */
+	sa_dfl.sa_handler =3D SIG_DFL;
+	sigaction(sig_num, &sa_dfl, NULL);
+	raise(sig_num);
+}
+
+static int read_stack_limit(void)
+{
+	unsigned long stack_start, stack_end;
+	struct rlimit rlim;
+	char line[256];
+	int ret =3D 0;
+	FILE *fp;
+
+	if (getrlimit(RLIMIT_STACK, &rlim)) {
+		ERROR_GLIBC("getrlimit");
+		return -1;
+	}
+
+	fp =3D fopen("/proc/self/maps", "r");
+	if (!fp) {
+		ERROR_GLIBC("fopen");
+		return -1;
+	}
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strstr(line, "[stack]")) {
+			if (sscanf(line, "%lx-%lx", &stack_start, &stack_end) !=3D 2) {
+				ERROR_GLIBC("sscanf");
+				ret =3D -1;
+				goto done;
+			}
+			stack_limit =3D stack_end - rlim.rlim_cur;
+			goto done;
+		}
+	}
+
+	ret =3D -1;
+	ERROR("/proc/self/maps: can't find [stack]");
+
+done:
+	fclose(fp);
+
+	return ret;
+}
+
+int init_signal_handler(void)
+{
+	int signals[] =3D {SIGSEGV, SIGBUS, SIGILL, SIGABRT};
+	struct sigaction sa;
+	stack_t ss;
+
+	if (read_stack_limit())
+		return -1;
+
+	ss.ss_sp =3D malloc(SIGSTKSZ);
+	if (!ss.ss_sp) {
+		ERROR_GLIBC("malloc");
+		return -1;
+	}
+	ss.ss_size =3D SIGSTKSZ;
+	ss.ss_flags =3D 0;
+
+	if (sigaltstack(&ss, NULL) =3D=3D -1) {
+		ERROR_GLIBC("sigaltstack");
+		return -1;
+	}
+
+	sa.sa_sigaction =3D signal_handler;
+	sigemptyset(&sa.sa_mask);
+
+	sa.sa_flags =3D SA_ONSTACK | SA_SIGINFO;
+
+	for (int i =3D 0; i < ARRAY_SIZE(signals); i++) {
+		if (sigaction(signals[i], &sa, NULL) =3D=3D -1) {
+			ERROR_GLIBC("sigaction");
+			return -1;
+		}
+	}
+
+	return 0;
+}

