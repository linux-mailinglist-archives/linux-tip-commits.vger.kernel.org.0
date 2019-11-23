Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE644107D84
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Nov 2019 09:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfKWIPZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 23 Nov 2019 03:15:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36339 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfKWIPY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZX-0002cN-4m; Sat, 23 Nov 2019 09:15:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 088C21C1ADA;
        Sat, 23 Nov 2019 09:15:03 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:02 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf dso: Move dso_id from 'struct map' to 'struct dso'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-g4hxxmraplo7wfjmk384mfsb@git.kernel.org>
References: <tip-g4hxxmraplo7wfjmk384mfsb@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157449690292.21853.1785343939983021929.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0e3149f86b99ddabde8c5029eea0a9267e34f1a0
Gitweb:        https://git.kernel.org/tip/0e3149f86b99ddabde8c5029eea0a9267e34f1a0
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 19 Nov 2019 18:44:22 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 19 Nov 2019 19:12:26 -03:00

perf dso: Move dso_id from 'struct map' to 'struct dso'

And take it into account when looking up DSOs when we have the dso_id
fields obtained from somewhere, like from PERF_RECORD_MMAP2 records.

Instances of struct map pointing to the same DSO pathname but with
anything in dso_id different are in fact different DSOs, so better have
different 'struct dso' instances to reflect that. At some point we may
want to get copies of the contents of the different objects if we want
to do correct annotation or other analysis.

With this we get 'struct map' 24 bytes leaner:

  $ pahole -C map ~/bin/perf
  struct map {
  	union {
  		struct rb_node     rb_node __attribute__((__aligned__(8))); /*     0    24 */
  		struct list_head   node;                 /*     0    16 */
  	} __attribute__((__aligned__(8)));               /*     0    24 */
  	u64                        start;                /*    24     8 */
  	u64                        end;                  /*    32     8 */
  	_Bool                      erange_warned:1;      /*    40: 0  1 */
  	_Bool                      priv:1;               /*    40: 1  1 */

  	/* XXX 6 bits hole, try to pack */
  	/* XXX 3 bytes hole, try to pack */

  	u32                        prot;                 /*    44     4 */
  	u64                        pgoff;                /*    48     8 */
  	u64                        reloc;                /*    56     8 */
  	/* --- cacheline 1 boundary (64 bytes) --- */
  	u64                        (*map_ip)(struct map *, u64); /*    64     8 */
  	u64                        (*unmap_ip)(struct map *, u64); /*    72     8 */
  	struct dso *               dso;                  /*    80     8 */
  	refcount_t                 refcnt;               /*    88     4 */
  	u32                        flags;                /*    92     4 */

  	/* size: 96, cachelines: 2, members: 13 */
  	/* sum members: 92, holes: 1, sum holes: 3 */
  	/* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 bits */
  	/* forced alignments: 1 */
  	/* last cacheline: 32 bytes */
  } __attribute__((__aligned__(8)));
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-g4hxxmraplo7wfjmk384mfsb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c |  2 +-
 tools/perf/util/dso.c       | 24 +++++++---
 tools/perf/util/dso.h       | 13 +++++-
 tools/perf/util/dsos.c      | 87 ++++++++++++++++++++++++++----------
 tools/perf/util/dsos.h      | 13 +----
 tools/perf/util/machine.c   |  7 ++-
 tools/perf/util/machine.h   |  2 +-
 tools/perf/util/map.c       |  8 +---
 tools/perf/util/map.h       | 16 +------
 tools/perf/util/sort.c      | 10 ++--
 10 files changed, 118 insertions(+), 64 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 04c197d..0b6157c 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -771,7 +771,7 @@ static size_t maps__fprintf_task(struct maps *maps, int indent, FILE *fp)
 				   map->prot & PROT_EXEC ? 'x' : '-',
 				   map->flags & MAP_SHARED ? 's' : 'p',
 				   map->pgoff,
-				   map->dso_id.ino, map->dso->name);
+				   map->dso->id.ino, map->dso->name);
 	}
 
 	return printed;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 0f1b772..91f2123 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1149,7 +1149,7 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 	return dso;
 }
 
-void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
+static void dso__set_long_name_id(struct dso *dso, const char *name, struct dso_id *id, bool name_allocated)
 {
 	struct rb_root *root = dso->root;
 
@@ -1162,8 +1162,8 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 	if (root) {
 		rb_erase(&dso->rb_node, root);
 		/*
-		 * __dsos__findnew_link_by_longname() isn't guaranteed to add it
-		 * back, so a clean removal is required here.
+		 * __dsos__findnew_link_by_longname_id() isn't guaranteed to
+		 * add it back, so a clean removal is required here.
 		 */
 		RB_CLEAR_NODE(&dso->rb_node);
 		dso->root = NULL;
@@ -1174,7 +1174,12 @@ void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
 	dso->long_name_allocated = name_allocated;
 
 	if (root)
-		__dsos__findnew_link_by_longname(root, dso, NULL);
+		__dsos__findnew_link_by_longname_id(root, dso, NULL, id);
+}
+
+void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated)
+{
+	dso__set_long_name_id(dso, name, NULL, name_allocated);
 }
 
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated)
@@ -1215,13 +1220,15 @@ void dso__set_sorted_by_name(struct dso *dso)
 	dso->sorted_by_name = true;
 }
 
-struct dso *dso__new(const char *name)
+struct dso *dso__new_id(const char *name, struct dso_id *id)
 {
 	struct dso *dso = calloc(1, sizeof(*dso) + strlen(name) + 1);
 
 	if (dso != NULL) {
 		strcpy(dso->name, name);
-		dso__set_long_name(dso, dso->name, false);
+		if (id)
+			dso->id = *id;
+		dso__set_long_name_id(dso, dso->name, id, false);
 		dso__set_short_name(dso, dso->name, false);
 		dso->symbols = dso->symbol_names = RB_ROOT_CACHED;
 		dso->data.cache = RB_ROOT;
@@ -1252,6 +1259,11 @@ struct dso *dso__new(const char *name)
 	return dso;
 }
 
+struct dso *dso__new(const char *name)
+{
+	return dso__new_id(name, NULL);
+}
+
 void dso__delete(struct dso *dso)
 {
 	if (!RB_EMPTY_NODE(&dso->rb_node))
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 2f1fcbc..2db64b7 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -122,6 +122,16 @@ enum dso_load_errno {
 #define DSO__DATA_CACHE_SIZE 4096
 #define DSO__DATA_CACHE_MASK ~(DSO__DATA_CACHE_SIZE - 1)
 
+/*
+ * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta events
+ */
+struct dso_id {
+	u32	maj;
+	u32	min;
+	u64	ino;
+	u64	ino_generation;
+};
+
 struct dso_cache {
 	struct rb_node	rb_node;
 	u64 offset;
@@ -196,6 +206,7 @@ struct dso {
 		u64	 db_id;
 	};
 	struct nsinfo	*nsinfo;
+	struct dso_id	 id;
 	refcount_t	 refcnt;
 	char		 name[0];
 };
@@ -214,9 +225,11 @@ static inline void dso__set_loaded(struct dso *dso)
 	dso->loaded = true;
 }
 
+struct dso *dso__new_id(const char *name, struct dso_id *id);
 struct dso *dso__new(const char *name);
 void dso__delete(struct dso *dso);
 
+int dso__cmp_id(struct dso *a, struct dso *b);
 void dso__set_short_name(struct dso *dso, const char *name, bool name_allocated);
 void dso__set_long_name(struct dso *dso, const char *name, bool name_allocated);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 1d38d6a..591707c 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -2,7 +2,6 @@
 #include "debug.h"
 #include "dsos.h"
 #include "dso.h"
-#include "map.h"
 #include "vdso.h"
 #include "namespaces.h"
 #include <libgen.h>
@@ -10,15 +9,8 @@
 #include <string.h>
 #include <symbol.h> // filename__read_build_id
 
-int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+static int __dso_id__cmp(struct dso_id *a, struct dso_id *b)
 {
-	/*
-	 * The second is always dso->id, so zeroes if not set, assume passing
-	 * NULL for a means a zeroed id
-	 */
-	if (a == NULL)
-		return 0;
-
 	if (a->maj > b->maj) return -1;
 	if (a->maj < b->maj) return 1;
 
@@ -34,6 +26,23 @@ int dso_id__cmp(struct dso_id *a, struct dso_id *b)
 	return 0;
 }
 
+static int dso_id__cmp(struct dso_id *a, struct dso_id *b)
+{
+	/*
+	 * The second is always dso->id, so zeroes if not set, assume passing
+	 * NULL for a means a zeroed id
+	 */
+	if (a == NULL)
+		return 0;
+
+	return __dso_id__cmp(a, b);
+}
+
+int dso__cmp_id(struct dso *a, struct dso *b)
+{
+	return __dso_id__cmp(&a->id, &b->id);
+}
+
 bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 {
 	bool have_build_id = false;
@@ -59,12 +68,30 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 	return have_build_id;
 }
 
+static int __dso__cmp_long_name(const char *long_name, struct dso_id *id, struct dso *b)
+{
+	int rc = strcmp(long_name, b->long_name);
+	return rc ?: dso_id__cmp(id, &b->id);
+}
+
+static int __dso__cmp_short_name(const char *short_name, struct dso_id *id, struct dso *b)
+{
+	int rc = strcmp(short_name, b->short_name);
+	return rc ?: dso_id__cmp(id, &b->id);
+}
+
+static int dso__cmp_short_name(struct dso *a, struct dso *b)
+{
+	return __dso__cmp_short_name(a->short_name, &a->id, b);
+}
+
 /*
  * Find a matching entry and/or link current entry to RB tree.
  * Either one of the dso or name parameter must be non-NULL or the
  * function will not work.
  */
-struct dso *__dsos__findnew_link_by_longname(struct rb_root *root, struct dso *dso, const char *name)
+struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
+						const char *name, struct dso_id *id)
 {
 	struct rb_node **p = &root->rb_node;
 	struct rb_node  *parent = NULL;
@@ -76,7 +103,7 @@ struct dso *__dsos__findnew_link_by_longname(struct rb_root *root, struct dso *d
 	 */
 	while (*p) {
 		struct dso *this = rb_entry(*p, struct dso, rb_node);
-		int rc = strcmp(name, this->long_name);
+		int rc = __dso__cmp_long_name(name, id, this);
 
 		parent = *p;
 		if (rc == 0) {
@@ -92,7 +119,7 @@ struct dso *__dsos__findnew_link_by_longname(struct rb_root *root, struct dso *d
 			 * In this case, the short name should be different.
 			 * Comparing the short names to differentiate the DSOs.
 			 */
-			rc = strcmp(dso->short_name, this->short_name);
+			rc = dso__cmp_short_name(dso, this);
 			if (rc == 0) {
 				pr_err("Duplicated dso name: %s\n", name);
 				return NULL;
@@ -115,7 +142,7 @@ struct dso *__dsos__findnew_link_by_longname(struct rb_root *root, struct dso *d
 void __dsos__add(struct dsos *dsos, struct dso *dso)
 {
 	list_add_tail(&dso->node, &dsos->head);
-	__dsos__findnew_link_by_longname(&dsos->root, dso, NULL);
+	__dsos__findnew_link_by_longname_id(&dsos->root, dso, NULL, &dso->id);
 	/*
 	 * It is now in the linked list, grab a reference, then garbage collect
 	 * this when needing memory, by looking at LRU dso instances in the
@@ -146,17 +173,27 @@ void dsos__add(struct dsos *dsos, struct dso *dso)
 	up_write(&dsos->lock);
 }
 
-struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+static struct dso *__dsos__findnew_by_longname_id(struct rb_root *root, const char *name, struct dso_id *id)
+{
+	return __dsos__findnew_link_by_longname_id(root, NULL, name, id);
+}
+
+static struct dso *__dsos__find_id(struct dsos *dsos, const char *name, struct dso_id *id, bool cmp_short)
 {
 	struct dso *pos;
 
 	if (cmp_short) {
 		list_for_each_entry(pos, &dsos->head, node)
-			if (strcmp(pos->short_name, name) == 0)
+			if (__dso__cmp_short_name(name, id, pos) == 0)
 				return pos;
 		return NULL;
 	}
-	return __dsos__findnew_by_longname(&dsos->root, name);
+	return __dsos__findnew_by_longname_id(&dsos->root, name, id);
+}
+
+struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short)
+{
+	return __dsos__find_id(dsos, name, NULL, cmp_short);
 }
 
 static void dso__set_basename(struct dso *dso)
@@ -191,9 +228,9 @@ static void dso__set_basename(struct dso *dso)
 	dso__set_short_name(dso, base, true);
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
+static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
-	struct dso *dso = dso__new(name);
+	struct dso *dso = dso__new_id(name, id);
 
 	if (dso != NULL) {
 		__dsos__add(dsos, dso);
@@ -204,18 +241,22 @@ struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
 	return dso;
 }
 
-struct dso *__dsos__findnew(struct dsos *dsos, const char *name)
+struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
 {
-	struct dso *dso = __dsos__find(dsos, name, false);
+	return __dsos__addnew_id(dsos, name, NULL);
+}
 
-	return dso ? dso : __dsos__addnew(dsos, name);
+static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
+{
+	struct dso *dso = __dsos__find_id(dsos, name, id, false);
+	return dso ? dso : __dsos__addnew_id(dsos, name, id);
 }
 
-struct dso *dsos__findnew(struct dsos *dsos, const char *name)
+struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso;
 	down_write(&dsos->lock);
-	dso = dso__get(__dsos__findnew(dsos, name));
+	dso = dso__get(__dsos__findnew_id(dsos, name, id));
 	up_write(&dsos->lock);
 	return dso;
 }
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index fd7ba51..5dbec2b 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -9,6 +9,7 @@
 #include "rwsem.h"
 
 struct dso;
+struct dso_id;
 
 /*
  * DSOs are put into both a list for fast iteration and rbtree for fast
@@ -24,15 +25,11 @@ void __dsos__add(struct dsos *dsos, struct dso *dso);
 void dsos__add(struct dsos *dsos, struct dso *dso);
 struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *__dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
-struct dso *__dsos__findnew(struct dsos *dsos, const char *name);
-struct dso *dsos__findnew(struct dsos *dsos, const char *name);
 
-struct dso *__dsos__findnew_link_by_longname(struct rb_root *root, struct dso *dso, const char *name);
-
-static inline struct dso *__dsos__findnew_by_longname(struct rb_root *root, const char *name)
-{
-	return __dsos__findnew_link_by_longname(root, NULL, name);
-}
+struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
+ 
+struct dso *__dsos__findnew_link_by_longname_id(struct rb_root *root, struct dso *dso,
+						const char *name, struct dso_id *id);
 
 bool __dsos__read_build_ids(struct list_head *head, bool with_hits);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 41b4263..e2a312c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2711,9 +2711,14 @@ out:
 	return addr_cpumode;
 }
 
+struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename, struct dso_id *id)
+{
+	return dsos__findnew_id(&machine->dsos, filename, id);
+}
+
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename)
 {
-	return dsos__findnew(&machine->dsos, filename);
+	return machine__findnew_dso_id(machine, filename, NULL);
 }
 
 char *machine__resolve_kernel_addr(void *vmachine, unsigned long long *addrp, char **modp)
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 1016978..499be20 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -11,6 +11,7 @@
 struct addr_location;
 struct branch_stack;
 struct dso;
+struct dso_id;
 struct evsel;
 struct perf_sample;
 struct symbol;
@@ -202,6 +203,7 @@ int machine__nr_cpus_avail(struct machine *machine);
 struct thread *__machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 struct thread *machine__findnew_thread(struct machine *machine, pid_t pid, pid_t tid);
 
+struct dso *machine__findnew_dso_id(struct machine *machine, const char *filename, struct dso_id *id);
 struct dso *machine__findnew_dso(struct machine *machine, const char *filename);
 
 size_t machine__fprintf(struct machine *machine, FILE *fp);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 812d663..744bfba 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -161,12 +161,6 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		anon = is_anon_memory(filename, flags);
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
-
-		if (id)
-			map->dso_id = *id;
-		else
-			map->dso_id.min = map->dso_id.ino = map->dso_id.ino_generation = 0;
-
 		map->prot = prot;
 		map->flags = flags;
 		nsi = nsinfo__get(thread->nsinfo);
@@ -196,7 +190,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			pgoff = 0;
 			dso = machine__findnew_vdso(machine, thread);
 		} else
-			dso = machine__findnew_dso(machine, filename);
+			dso = machine__findnew_dso_id(machine, filename, id);
 
 		if (dso == NULL)
 			goto out_delete;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index e1e573a..5e88998 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -18,18 +18,6 @@ struct map_groups;
 struct machine;
 struct evsel;
 
-/*
- * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta events
- */
-struct dso_id {
-	u32	maj;
-	u32	min;
-	u64	ino;
-	u64	ino_generation;
-};
-
-int dso_id__cmp(struct dso_id *a, struct dso_id *b);
-
 struct map {
 	union {
 		struct rb_node	rb_node;
@@ -49,7 +37,6 @@ struct map {
 	u64			(*unmap_ip)(struct map *, u64);
 
 	struct dso		*dso;
-	struct dso_id		dso_id;
 	refcount_t		refcnt;
 	u32			flags;
 };
@@ -118,6 +105,9 @@ struct thread;
 
 void map__init(struct map *map,
 	       u64 start, u64 end, u64 pgoff, struct dso *dso);
+
+struct dso_id;
+
 struct map *map__new(struct machine *machine, u64 start, u64 len,
 		     u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
 		     char *filename, struct thread *thread);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f148100..345b5cc 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1213,7 +1213,7 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 	if (!l_map) return -1;
 	if (!r_map) return 1;
 
-	rc = dso_id__cmp(&l_map->dso_id, &r_map->dso_id);
+	rc = dso__cmp_id(l_map->dso, r_map->dso);
 	if (rc)
 		return rc;
 	/*
@@ -1226,8 +1226,8 @@ sort__dcacheline_cmp(struct hist_entry *left, struct hist_entry *right)
 
 	if ((left->cpumode != PERF_RECORD_MISC_KERNEL) &&
 	    (!(l_map->flags & MAP_SHARED)) &&
-	    !l_map->dso_id.maj && !l_map->dso_id.min &&
-	    !l_map->dso_id.ino && !l_map->dso_id.ino_generation) {
+	    !l_map->dso->id.maj && !l_map->dso->id.min &&
+	    !l_map->dso->id.ino && !l_map->dso->id.ino_generation) {
 		/* userspace anonymous */
 
 		if (left->thread->pid_ > right->thread->pid_) return -1;
@@ -1263,8 +1263,8 @@ static int hist_entry__dcacheline_snprintf(struct hist_entry *he, char *bf,
 		if ((he->cpumode != PERF_RECORD_MISC_KERNEL) &&
 		     map && !(map->prot & PROT_EXEC) &&
 		    (map->flags & MAP_SHARED) &&
-		    (map->dso_id.maj || map->dso_id.min ||
-		     map->dso_id.ino || map->dso_id.ino_generation))
+		    (map->dso->id.maj || map->dso->id.min ||
+		     map->dso->id.ino || map->dso->id.ino_generation))
 			level = 's';
 		else if (!map)
 			level = 'X';
