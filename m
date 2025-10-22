Return-Path: <linux-tip-commits+bounces-6979-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DF0BFACB7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 10:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C7A463D59
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Oct 2025 08:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546473002B6;
	Wed, 22 Oct 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PTbanoCv"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8251A2FB61D
	for <linux-tip-commits@vger.kernel.org>; Wed, 22 Oct 2025 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120434; cv=none; b=hpQTP4sJ54EopnFu38Whr4jLp0KT+5HtrU7ny1HFKIjlV1an05IDQrqufWCU00HNgy/nEKXEjJgrwZngyQmsAJveyv+wkWOhUhGpAaIMDpgGBKCDwqGktj8v3zvNjO6XINTclQj3h4AAYXmKlJSvnlftCGGnySU4GFFMweiMykE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120434; c=relaxed/simple;
	bh=z5aTq/b4M0UfRIna7S0Nhil0NVF8yO2tdo+MZwdKbY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkwegFEvqjrednLdA0eIhfE7VrmNW8nKWv9PaoFJ3QYwGf065uthC71mkAUJvsc/OGH58voE+13qKyUjxa6ziimuXLtrBw9RLK+dlDymuKZn0yPLW+SaVMx5K9SVQKHV7hmYhyzyCskSWKHgGaozKFThu2XDdM7TQgv9keHjN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PTbanoCv; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3307de086d8so5432786a91.2
        for <linux-tip-commits@vger.kernel.org>; Wed, 22 Oct 2025 01:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761120430; x=1761725230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVye5zs+1UdFAhZPVYZSif7IzMdgoQT4jHpA3BFx5Og=;
        b=PTbanoCvl05zGhT0wiwxMdzIo4efsVAvfpxl/lb7VQS72T1h2yNkRsRQOm+kNyc/n8
         7u+W0aJBnhFQCbxJSd0C5Vu9YNz/dtWiQaR3n7sS5ZBEQIEnSDu4msBtuzifeRwkdkpi
         nGa1+VgZO0JazAexpvuITIQATt5/ApdHVIMLflX/W1b/8eU3TMR8i1Hel0pfIaNGyWZa
         /6MDLRtCk2N+PzFFCV/0vxibmmfgXGllFXeG4TttwcobNmnXwBWcFfCTspmZMEAF5qK3
         LlxBUmSqJ4L2Inm1H+QtwMSms1jYxL3dIlJafVJxATlPVSi4Ob/sV2zNxCurtJXxVg8p
         Svbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120430; x=1761725230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVye5zs+1UdFAhZPVYZSif7IzMdgoQT4jHpA3BFx5Og=;
        b=AJcPlcFcYEqKWLdFU+9+hdRRaP3ncTnGsX0KxXf5tz0ecTvEZVqnhY/xSSNQgSo9m8
         YK27XBCEfkwOH9BSNMoE3zmlTRxXT97PA0Qrbg5dg/W8pPTF2svUNRs+6GHY8lHG8E5W
         ctKdUXUcr7EhcxMms4rFomHvVI+xmiDnzbUlMfMXW6CrcmXzH/seEhFmLAdrcv28jbMF
         ijOWkkno76ECcbgyF1BYOx1CnYpnKFP1xAFWxEjfG1FNGkZAnowG4NZKDRuouKnfRave
         Z1D4muzHqwmL2I73W89nbqhKN7B7TbePNEbyAMfNhhEGqkW+MkVBNlyzW5LyxdwqDW7h
         CmgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiYII/Z2ZI+DHUCy6avp8em6biDD7bt5/QG4Ij/noznZOwAoiLv9inXY7vkiduwu5Ua2yZEBysjF37ECPODloYjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS5yRrWac2QJPmp/bEuX+pGcF1XK3JnuWMI9+W6Bsgv+/AM6T
	DCU4nXcnix7q0JIcmdhD90LvylsfiLHdVXnArsLyItzwZMGrG2F/oQAvMUCCRmXVgYU=
X-Gm-Gg: ASbGncvXSlbX11Px/CWGy9zQqQPVdawRzY11hFg4GsAuCjDg1KJ2nqXLEW/i5YyueSr
	BpE9ErideV0zpd7r1JpFgnD3HKqRNSwPgkNeezutzW+ucso2A0nXBV+1upTOxDOBk3isznJpis6
	DUwY4jkkzaWR/2ywXNdcla4HYrd4HIuccB6kPrDuspq5n36N/tdH3W3zJW6ndoHmzhPfbHZIRsw
	KOZwBWAm4kPMCGn9a3/QVowX6Ox0BpLes+qNKgwuQ5Cvduj2P17Y6JiHrLR2ARza3G1BL5fj0zV
	vW8iMfuIMsgKF7AI04WxXVR0gHfbY9mRRKEwY1Ep29kcydeiSYMQpHYPDwrfGlXqt7o6I0pgV3b
	eBekc6mp4WWgAV4ayHFhXvJ+f7J8OJanNRg7klI6iaRDzFo3mjBjD2sER2ZzkRfrLNPykiAQ+o+
	5ZQggO3z1d884qD0MtK3ddIUZRLyQpzxZSgAfmV+CAPbAfwBrSRA==
X-Google-Smtp-Source: AGHT+IG3hlOFcvWSP4lTtCTDORWoLEgNinA/eeF0Qje86Kf288ToBctAHsrKUmoZDuTIkRc+/1gxxw==
X-Received: by 2002:a17:90b:3e43:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-33bcf85ada9mr22062706a91.1.1761120430178;
        Wed, 22 Oct 2025 01:07:10 -0700 (PDT)
Received: from localhost ([2405:201:c438:503a:cad2:498b:1c6f:5102])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm12146711a12.10.2025.10.22.01.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:07:09 -0700 (PDT)
From: Naresh Kamboju <naresh.kamboju@linaro.org>
To: tip-bot2@linutronix.de
Cc: arthur.marsh@internode.on.net,
	jpoimboe@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: re: tools build: Fix fixdep dependencies
Date: Wed, 22 Oct 2025 13:37:05 +0530
Message-ID: <20251022080705.38771-1-naresh.kamboju@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
References: <176060840507.709179.15363439615733763867.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 18, 2025 at 07:12:02AM +0200, Thorsten Leemhuis wrote:
>>On 10/16/25 11:53, tip-bot2 for Josh Poimboeuf wrote:
>>>>The following commit has been merged into the objtool/core branch of tip:
>>>>
>>>>Commit-ID:     a808a2b35f66658e6c49dc98b55a33fa1079fe72
>>>>Gitweb:        https://git.kernel.org/tip/a808a2b35f66658e6c49dc98b55a33fa1079fe72
>>>>Author:        Josh Poimboeuf <jpoimboe@kernel.org>
>>>>AuthorDate:    Sun, 02 Mar 2025 17:01:42 -08:00
>>>>Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
>>>>CommitterDate: Tue, 14 Oct 2025 14:45:20 -07:00
>>>>
>>>>tools build: Fix fixdep dependencies
>>>>
>>>>The tools version of fixdep has broken dependencies.  It doesn't get
>>>>rebuilt if the host compiler or headers change.
>>
>>My daily -next rebuilds based on the Fedora rawhide srpm failed due to
>>this patch while building perf:
>>
>>make[4]: *** No rule to make target '/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/fixdep'.  Stop.
>>make[3]: *** [/builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/build/Makefile.include:15: fixdep] Error 2
>>make[2]: *** [Makefile.perf:981: /builddir/build/BUILD/kernel-6.18.0-build/kernel-next-20251017/linux-6.18.0-0.0.next.20251017.420.vanilla.fc44.aarch64/tools/perf/libsubcmd/libsubcmd.a] Error 2
>>make[2]: *** Waiting for unfinished jobs....
>>
>>Full log: https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-rawhide-aarch64/09700031-next-next-all/builder-live.log.gz
>>
>>Happened on ppc64 and s390x, too (and likely on x86_64, too, but that
>>failed earlier during the build due to an unrelated problem).
>>
>>Reverting this change fixed the problem.

The LKFT also found these perf build regressions on the Linux next-20251017.

Build regressions:  No rule to make target 'build/libsubcmd/fixdep'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error
 CC      /home/tuxbuild/.cache/tuxmake/builds/1/build/libperf/core.o
make[4]: *** No rule to make target '/home/tuxbuild/.cache/tuxmake/builds/1/build/libsubcmd/fixdep'.  Stop.
make[3]: *** [/builds/linux/tools/build/Makefile.include:15: fixdep] Error 2
make[2]: *** [Makefile.perf:981: /home/tuxbuild/.cache/tuxmake/builds/1/build/libsubcmd/libsubcmd.a] Error 2

> Thanks, I will post a fix for this shortly.

When you have fix ready please CC LKFT, I am happy to test.
 lkft-triage@lists.linaro.org
 naresh.kamboju@linaro.org

-- 
Josh


