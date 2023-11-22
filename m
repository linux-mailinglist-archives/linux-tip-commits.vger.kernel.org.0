Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABA67F532B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Nov 2023 23:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjKVWSB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Nov 2023 17:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjKVWSA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Nov 2023 17:18:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2941B6
        for <linux-tip-commits@vger.kernel.org>; Wed, 22 Nov 2023 14:17:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-daed1e15daeso371313276.1
        for <linux-tip-commits@vger.kernel.org>; Wed, 22 Nov 2023 14:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700691474; x=1701296274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4w9WGlpV+oKNURgCWJmbzMqmytRuxi/IH9HmVAy3vpk=;
        b=4hjMcBVLM8zQ0o7ckWNrtY5BsbegukXIEDCvOawcAjUnR1XZjDCORBx8DRNRNpcLGJ
         rOYRo1YK1VQ2y0xyZgScQZyb9rLYqzZOdgDtDkghSXkXdkKxJ1HtozUHmVoQlTxztPqK
         kfOhbHSin5lmjeY12WuVf3III/SL6gBe6BSXI/YQ3KWRvnMIzEozhG1LYLLMFfbbv0Jq
         ECkYybq5VMDleTKLyzIh94t5LKbB+K2jpi6OvcJJJrWqJhj5bT4OCTe2UNqnJgtJGYUO
         7Jc+PqUsyTYlSgXIsMOQgTwV6uQKHFkFZagr5e5Tj13O5S9UO71JOWXdU+tIYBbkJVpA
         bzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700691474; x=1701296274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4w9WGlpV+oKNURgCWJmbzMqmytRuxi/IH9HmVAy3vpk=;
        b=uRQzg9BjM5h6dds12aEUwlBvRcq1zlwUpShJAoTAZm6cZBaMJkmT0i4JE734sJDGX2
         k98RqA7Cy66/Rvs5Tb7JP5xVIwKFa0iVGaxi5ZP8GzOIkYy7COqyGbm1tMECRpYTOZvZ
         rmAn39fY30ijNWKGSg2CT1ko7Qyul/SwEQfOfg/7p7JQ4H2hxwzprmyYMMwVJdh8ynwS
         DM2argjNtbQSwwpca+ymLB1MabBdPskMbHF6NLrVYwG9HkNCLl4TwgG0/V83ToM7JPuZ
         EKetyseJgB1M+JAm7SxuhEaJA/YyKCzk3VHZbtR42jZ15INJ944atTr1BKH1E+x7Sm2Y
         7tAQ==
X-Gm-Message-State: AOJu0YxiRIa2+IWjVZlQQN1XKgH0bfY5+cyoLfmSFGWCjQ/RuQbe1E+p
        pd+yge23kqKuMi3OvQht/OxGn1H3Bsy4JE4=
X-Google-Smtp-Source: AGHT+IEWzYwUAnR9oEjMHGBr1ZPorbK5SniZIIxjSugb5DV844aPwk+jzNuLEfBvJKKK7SIXsJ76dKbPGg3skas=
X-Received: from jsperbeck7.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:26dc])
 (user=jsperbeck job=sendgmr) by 2002:a25:d844:0:b0:dae:292e:68de with SMTP id
 p65-20020a25d844000000b00dae292e68demr106468ybg.6.1700691474042; Wed, 22 Nov
 2023 14:17:54 -0800 (PST)
Date:   Wed, 22 Nov 2023 22:17:52 +0000
In-Reply-To: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
Mime-Version: 1.0
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122221752.781022-1-jsperbeck@google.com>
Subject: [PATCH] platform/x86: intel_telemetry: Fix kernel doc descriptions
From:   John Sperbeck <jsperbeck@google.com>
To:     tip-bot2@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        peterz@infradead.org, rui.zhang@intel.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries for
each CPU.  However, the ids for the LOCAL_APIC entries are all
invalid ids of 255, so they have always been skipped in acpi_parse_lapic()
by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff from being
accounted"):

    /* Ignore invalid ID */
    if (processor->id == 0xff)
            return 0;

With the change in this thread, the return value of 0 means that the
'count' variable in acpi_parse_entries_array() is incremented.  The
positive return value means that 'has_lapic_cpus' is set, even though
no entries were actually matched.  Then, when the MADT is iterated
with acpi_parse_x2apic(), the x2apic entries with ids less than 255
are skipped and most of my CPUs aren't recognized.

I think the original version of this change was okay for this case in
https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/

P.S. I could be convinced that the MADT for my platform is somewhat
ill-formed and that I'm relying on pre-existing behavior.  I'm not
well-versed enough in the topic to know for sure.
